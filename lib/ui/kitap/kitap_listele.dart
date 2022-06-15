// ignore: file_names
import 'package:bunudaoku/ui/kitap/kitap_duzenle.dart';
import 'package:bunudaoku/ui/kitap/kitap_sil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/Kitap.dart';

class KitapListele extends StatefulWidget {
  const KitapListele({Key? key}) : super(key: key);

  @override
  State<KitapListele> createState() => _KitapListeleState();
}

class _KitapListeleState extends State<KitapListele> {
  final Stream<QuerySnapshot> kitaplarStream =
      FirebaseFirestore.instance.collection('kitaplar').snapshots();

  //Delete

  String textKisalt(yazi) {
    if (yazi.length > 10) {
      return yazi.substring(0, 8).toString() + "...";
    }
    return yazi;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: kitaplarStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(
                msg: 'HATA OLUŞTUR !! ',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white70,
                fontSize: 16.0);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List kitaplardocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            kitaplardocs.add(a);
            a['id'] = document.id;
          }).toList();
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 220,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                columnWidths: {
                  0: FlexColumnWidth(0.2),
                  1: FlexColumnWidth(0.2),
                  2: FlexColumnWidth(0.25),
                  3: FlexColumnWidth(0.22),
                  //4: FlexColumnWidth(0.2),
                },
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      TableCell(
                          child: Container(
                              color: Colors.greenAccent,
                              child: const Center(
                                child: Text(
                                  'Kitap Adı:',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                      TableCell(
                        child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                            child: Text(
                              'Kiyap Yazarı',
                              overflow: TextOverflow.clip,
                              softWrap: false,
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
                    TableRow(children: [
                      TableCell(
                          child: TableRowInkWell(
                        onLongPress: () =>
                            {print(kitaplardocs[i]['id'].toString())},
                        child: Center(
                            child: Text(
                                textKisalt(
                                    kitaplardocs[i]['kitapadi'].toString()),
                                overflow: TextOverflow.fade,
                                style: const TextStyle(fontSize: 14.0))),
                      )),
                      TableCell(
                        child: TableRowInkWell(
                          onLongPress: () =>
                              {print(kitaplardocs[i]['id'].toString())},
                          child: Center(
                              child: Text(
                                  textKisalt(
                                      kitaplardocs[i]['kitapyazar'].toString()),
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: const TextStyle(fontSize: 14.0))),
                        ),
                      ),
                      TableCell(
                        child: TableRowInkWell(
                          onLongPress: () =>
                              {print(kitaplardocs[i]['id'].toString())},
                          child: Center(
                            child: Text(
                              textKisalt(
                                  kitaplardocs[i]['kitapozet'].toString()),
                              overflow: TextOverflow.fade,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                final kitap = Kitap(
                                    kitapadi:kitaplardocs[i]['kitapadi'],
                                    kitapozet:kitaplardocs[i]['kitapozet'],
                                    kitapyazar:kitaplardocs[i]['kitapyazar'],
                                    kitapid: kitaplardocs[i]['id']);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KitapDuzenle(
                                            kitap: kitap,
                                            kitapid: kitaplardocs[i]['id']
                                                .toString())));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                final kitap = Kitap(
                                    kitapadi:kitaplardocs[i]['kitapadi'],
                                    kitapozet:kitaplardocs[i]['kitapozet'],
                                    kitapyazar:kitaplardocs[i]['kitapyazar'],

                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => KitapSil(
                                            kitap: kitap,
                                            kitapid: kitaplardocs[i]['id']
                                                .toString())));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])
                  ]
                ],
              ),
            ),
          );
        });
    /*var kitapListe = [
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
    ];**/
  }
}
