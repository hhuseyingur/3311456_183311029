import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DergiListele extends StatefulWidget {
  const DergiListele({Key? key}) : super(key: key);

  @override
  State<DergiListele> createState() => _DergiListeleState();
}

class _DergiListeleState extends State<DergiListele> {
  
  final Stream<QuerySnapshot> dergilerStream = FirebaseFirestore.instance.collection('dergiler').snapshots();

  //Delete
  CollectionReference dergiler = FirebaseFirestore.instance.collection('dergiler');
  Future<void> deleteDergi(id) {
    return dergiler.doc(id).delete()
        .then((value) => {
      Fluttertoast.showToast(
          msg: 'Dergi Başarıyla Silindi',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.black87,
          fontSize: 16.0)})
        .catchError((error)=>{
      Fluttertoast.showToast(
          msg: 'HATA OLUŞTU !! $error',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white70,
          fontSize: 16.0)
    });
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: dergilerStream,
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot ){
          if(snapshot.hasError) {
            Fluttertoast.showToast(
                msg: 'HATA OLUŞTUR !! ',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white70,
                fontSize: 16.0);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child:CircularProgressIndicator(),
            );
          }
          final List dergilerdocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            dergilerdocs.add(a);
            a['id'] = document.id;
            print(dergilerdocs);
          }).toList();

          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 220,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child: Table(

                  defaultColumnWidth: FlexColumnWidth(1),
                  border: TableBorder.all(),
                  columnWidths: const <int,TableColumnWidth>{
                    1:IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(

                      children: [
                        TableCell(child: Container(

                            color: Colors.greenAccent,
                            child: const Center(
                              child: Text(
                                'Dergi Adı:',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                        )
                        ),
                        TableCell(

                          child: Container(
                            color: Colors.greenAccent,
                            child: const Center(
                              child: Text(
                                'Dergi Sayı',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(

                          child: Container(
                            color: Colors.greenAccent,
                            child: const Center(
                              child: Text(
                                'Dergi Ozet',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(

                          child: Container(
                            color: Colors.greenAccent,
                            child: const Center(
                              child: Text(
                                'İşlem',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (var i = 0; i < dergilerdocs.length; i++) ...[

                      TableRow(
                          children: [
                            TableCell(

                              child: Center(
                                  child: Text(dergilerdocs[i]['dergiadi'],
                                      style: const TextStyle(fontSize: 14.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(dergilerdocs[i]['dergisayi'],
                                      style: const TextStyle(fontSize: 14.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(dergilerdocs[i]['dergiozet'],
                                      style: const TextStyle(fontSize: 14.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      print('DETAY DERGİ ${dergilerdocs[i]['id']}')
                                      /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateStudentPage(
                                        id: storedocs[i]['id']),
                                  ),
                                )
                                 */
                                      //print("detay")
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                    //{deleteUser(storedocs[i]['id'])},
                                    print("test"),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                      )
                    ]
                  ],
                ),
              )
          );
        });

  }
}
