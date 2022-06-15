import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GazeteListelee extends StatefulWidget {
  const GazeteListelee({Key? key}) : super(key: key);

  @override
  State<GazeteListelee> createState() => _GazeteListeleeState();
}

class _GazeteListeleeState extends State<GazeteListelee> {

  final Stream<QuerySnapshot> gazetelerStream = FirebaseFirestore.instance.collection('gazeteler').snapshots();

  //Delete
  CollectionReference gazeteler = FirebaseFirestore.instance.collection('gazeteler');
  Future<void> deleteGazete(id){
    return gazeteler.doc(id).delete()
        .then((value) =>{
      Fluttertoast.showToast(
          msg: 'Gazete Başarıyla Silindi',
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
        stream: gazetelerStream,
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
          final List gazetelerdocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            gazetelerdocs.add(a);
            a['id'] = document.id;
            print(gazetelerdocs);
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
                                'Gazete Adı:',
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
                                'Gazete No',
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
                    for (var i = 0; i < gazetelerdocs.length; i++) ...[

                      TableRow(
                          children: [
                            TableCell(

                              child: Center(
                                  child: Text(gazetelerdocs[i]['gazeteadi'],
                                      style: const TextStyle(fontSize: 14.0))),
                            ),
                            TableCell(
                              child: Center(
                                  child: Text(gazetelerdocs[i]['gazeteno'],
                                      style: const TextStyle(fontSize: 14.0))),
                            ),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => {
                                      print('DETAY GAZETE ${gazetelerdocs[i]['id']}')
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

    var gazeteListe = [
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Gazete Adı 1'),
        subtitle: Text('Gazete No : 1'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Gazete Adı 2'),
        subtitle: Text('Gazete No : 2'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Gazete Adı 3'),
        subtitle: Text('Gazete No : 3'),
      ),
    ];
    return Scaffold(
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: gazeteListe.length,
            itemBuilder: (context, index) {
              var gazeteList = gazeteListe[index];
              return gazeteList;
            }),
      ),
    );
  }
}