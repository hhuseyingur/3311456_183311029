// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KitapListele extends StatefulWidget {
  const KitapListele({Key? key}) : super(key: key);

  @override
  State<KitapListele> createState() => _KitapListeleState();
}

class _KitapListeleState extends State<KitapListele> {

  final Stream<QuerySnapshot> kitaplarStream = FirebaseFirestore.instance.collection('kitaplar').snapshots();

  //Delete
  CollectionReference kitaplar = FirebaseFirestore.instance.collection('kitaplar');
  Future<void> deleteKitap(id) {
    return kitaplar.doc(id).delete()
        .then((x) => {
          Fluttertoast.showToast(
            msg: 'Kitap Başarıyla Silindi',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.black87,
          fontSize: 16.0)})
        .catchError((error)=>{
      Fluttertoast.showToast(
          msg: 'HATA OLUŞTUR !! $error',
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
    return StreamBuilder<QuerySnapshot>(
      stream: kitaplarStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
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

        final List kitaplardocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          kitaplardocs.add(a);
          a['id'] = document.id;
        }).toList();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
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
                          'Kitap Adı:',
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
                            'Kiyap Yazarı',
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
                            'Kitap Özeti/Notları',
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
                for (var i = 0; i < kitaplardocs.length; i++) ...[
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(
                            child: Text(kitaplardocs[i]['kitapadi'],
                                style: const TextStyle(fontSize: 14.0))),
                      ),
                      TableCell(
                        child: Center(
                            child: Text(kitaplardocs[i]['kitapyazar'],
                                style: const TextStyle(fontSize: 14.0))),
                      ),
                      TableCell(
                        child: Center(
                            child: Text(kitaplardocs[i]['kitapozet'],
                                style: const TextStyle(fontSize: 14.0))),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => {
                                /*
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateStudentPage(
                                        id: storedocs[i]['id']),
                                  ),
                                )
                                 */
                                print("detay")
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
          ),
        );
      });
    var kitapListe = [
      ListTile(
        //onTap:() {},
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('asd'),
      ),
      const ListTile(
        //onTap:() {},
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Kitap 1'),
        subtitle: Text('Yazar : Yazar 1'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Kitap 2'),
        subtitle: Text('Yazar : Yazar 2'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Kitap 3'),
        subtitle: Text('Yazar : Yazar 3'),
      ),
    ];

  }
}
