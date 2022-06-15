// ignore: file_names

import 'package:bunudaoku/models/Kitap.dart';
import 'package:bunudaoku/ui/kitap/kitap_detay.dart';
import 'package:bunudaoku/ui/kitap/kitap_duzenle.dart';
import 'package:bunudaoku/widget/list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KitapListelee extends StatefulWidget {
  const KitapListelee({Key? key}) : super(key: key);

  @override
  State<KitapListelee> createState() => _KitapListeeleState();
}

class _KitapListeeleState extends State<KitapListelee> {
  Stream<QuerySnapshot> kitaplarStream =
      FirebaseFirestore.instance.collection('kitaplar').snapshots();
  CollectionReference kitaplar =
      FirebaseFirestore.instance.collection('kitaplar');

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

        final List<Kitap> kitaplardocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Kitap kitap =
              Kitap.fromJson(map: document.data() as Map<String, dynamic>);
          kitaplardocs.add(kitap);
          kitap.kitapid = document.id;
          print(kitap.kitapid);
        }).toList();
        return RefreshIndicator(
          onRefresh: () async {
            setState(() {
              kitaplarStream =
                  FirebaseFirestore.instance.collection('kitaplar').snapshots();
            });
          },
          child: ListView.builder(
              itemCount: kitaplardocs.length,
              itemBuilder: ((BuildContext context, int i) {
                Kitap kitap = kitaplardocs[i];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    setState(() {
                      kitaplardocs.removeAt(i);
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
                                      kitaplar
                                          .doc(kitaplardocs[i].kitapid)
                                          .delete()
                                          .then((x) => {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'Kitap Başarıyla Silindi',
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
                                                    backgroundColor: Colors.red,
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
                                          builder: (context) => KitapDuzenle(
                                            kitap: kitaplardocs[i],
                                            kitapid: kitaplardocs[i]
                                                .kitapadi
                                                .toString(),
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
                    return null;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTileCustom(
                      titleText:
                          "Kitap Adı : " + kitaplardocs[i].kitapadi.toString(),
                      subtitleText:
                          "Yazar : " + kitaplardocs[i].kitapyazar.toString(),
                      leadingIcon: Icons.book,
                      iconColor: Colors.blue,
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => KitapDetay(
                              kitap: kitaplardocs[i],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              })),
        );
      },
    );
  }
}
