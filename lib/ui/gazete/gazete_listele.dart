import 'package:bunudaoku/models/Gazete.dart';
import 'package:bunudaoku/ui/gazete/gazete_detay.dart';
import 'package:bunudaoku/ui/gazete/gazete_duzenle.dart';
import 'package:bunudaoku/widget/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GazeteListele extends StatefulWidget {
  const GazeteListele({Key? key}) : super(key: key);

  @override
  State<GazeteListele> createState() => _GazeteListeleState();
}

class _GazeteListeleState extends State<GazeteListele> {
  Stream<QuerySnapshot> gazetelerStream =
      FirebaseFirestore.instance.collection('gazeteler').snapshots();

  //Delete
  CollectionReference gazeteler =
      FirebaseFirestore.instance.collection('gazeteler');
  Future<void> deleteGazete(id) {
    return gazeteler
        .doc(id)
        .delete()
        .then((value) => {
              Fluttertoast.showToast(
                  msg: 'Gazete Başarıyla Silindi',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.amber,
                  textColor: Colors.black87,
                  fontSize: 16.0)
            })
        .catchError((error) => {
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
          final List<Gazete> gazeteList = [];

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Gazete gazete =
                Gazete.fromJson(map: document.data() as Map<String, dynamic>);
            gazete.gazeteid = document.id;
            gazeteList.add(gazete);
          }).toList();

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                gazetelerStream = FirebaseFirestore.instance
                    .collection('gazeteler')
                    .snapshots();
              });
            },
            child: ListView.builder(
                itemCount: gazeteList.length,
                itemBuilder: ((BuildContext context, int i) {
                  Gazete gazete = gazeteList[i];
                  //print("gazete id : "+gazete.gazeteid.toString());
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      setState(() {
                        gazeteList.removeAt(i);
                      });
                    },
                    background: Container(
                      color: Colors.red.shade800,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.delete_forever, color: Colors.white),
                            Text('Sil', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    confirmDismiss: (DismissDirection direction) async {
                      switch (direction) {
                        case DismissDirection.startToEnd:
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Veri silinsin mi?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        gazeteler
                                            .doc(gazete.gazeteid)
                                            .delete()
                                            .then((x) => {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Gazete Başarıyla Silindi',
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.amber,
                                                      textColor: Colors.black87,
                                                      fontSize: 16.0)
                                                })
                                            .catchError((error) => {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'HATA OLUŞTU !! $error',
                                                      toastLength:
                                                          Toast.LENGTH_LONG,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:
                                                          Colors.red,
                                                      textColor: Colors.white70,
                                                      fontSize: 16.0)
                                                });

                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text("Sil")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Geri"),
                                  ),
                                ],
                              );
                            },
                          );
                        case DismissDirection.endToStart:
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    "Veriyi düzenlemek istiyor musunuz?"),
                                actions: <Widget>[
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GazeteDuzenle(
                                              gazete: gazete,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text("Düzenle")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("Geri"),
                                  ),
                                ],
                              );
                            },
                          );

                        default:
                      }
                    },
                    secondaryBackground: Container(
                      color: Colors.blue.shade300,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const <Widget>[
                            Icon(Icons.edit, color: Colors.white),
                            Text('Düzenle',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListTileCustom(
                        titleText: "Gazete Adı : " + gazete.gazeteadi,
                        subtitleText: "Gazete No : " + gazete.gazeteno,
                        leadingIcon: Icons.art_track,
                        iconColor: Colors.blue,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>  GazeteDetay(gazete: gazete),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                })),
          );
        });
  }
}
