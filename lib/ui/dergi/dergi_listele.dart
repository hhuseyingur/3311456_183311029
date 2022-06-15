import 'package:bunudaoku/models/Dergi.dart';
import 'package:bunudaoku/ui/dergi/dergi_detay.dart';
import 'package:bunudaoku/ui/dergi/dergi_duzenle.dart';
import 'package:bunudaoku/widget/list_tile.dart';
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
  Stream<QuerySnapshot> dergilerStream =
      FirebaseFirestore.instance.collection('dergiler').snapshots();

  //Delete
  CollectionReference dergiler =
      FirebaseFirestore.instance.collection('dergiler');
  Future<void> deleteDergi(id) {
    return dergiler
        .doc(id)
        .delete()
        .then((value) => {
              Fluttertoast.showToast(
                  msg: 'Dergi Başarıyla Silindi',
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
        stream: dergilerStream,
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
          final List<Dergi> dergiList = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> map = document.data() as Map<String, dynamic>;
            Dergi dergi = Dergi.fromJson(map: map);
            dergiList.add(dergi);
            dergi.id = document.id;
          }).toList();

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                dergilerStream = FirebaseFirestore.instance
                    .collection('dergiler')
                    .snapshots();
              });
            },
            child: ListView.builder(
                itemCount: dergiList.length,
                itemBuilder: ((BuildContext context, int i) {
                  Dergi dergi = dergiList[i];
                  //print("gazete id : "+gazete.gazeteid.toString());
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      setState(() {
                        dergiList.removeAt(i);
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
                                        deleteDergi(dergi.id);

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
                                            builder: (context) => DergiDuzenle(
                                              dergi: dergi,
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
                        titleText: "Dergi Adı : " + dergi.dergiadi,
                        subtitleText: "Dergi Sayı : " + dergi.dergisayi,
                        leadingIcon: Icons.analytics,
                        iconColor: Colors.blue,
                        textColor: Colors.black,
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => DergiDetay(dergi: dergi),
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
