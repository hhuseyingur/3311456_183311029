import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../models/Kitap.dart';

class KitapSil extends StatelessWidget {
  const KitapSil({Key? key, required this.kitap, this.kitapid}) : super(key: key);
  final Kitap kitap;
  final kitapid;

  @override
  Widget build(BuildContext context) {

    CollectionReference kitaplar =
        FirebaseFirestore.instance.collection('kitaplar');

    Future<void> deleteKitap(id) {
      return kitaplar
          .doc(id)
          .delete()
          .then((x) => {
                Fluttertoast.showToast(
                    msg: 'Kitap Başarıyla Silindi',
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

    return Scaffold(
        appBar: AppBar(
          title: Text(kitap.kitapadi + " Silme Ekranı"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Center(
                child: Text.rich(TextSpan(
                    text: "Kitap İsmi: " + kitap.kitapadi,
                    style: TextStyle(fontSize: 20))),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity / 1.2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (context) => Center(
                              child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                            ),
                            onPressed: () {
                              deleteKitap(kitapid);
                              Navigator.of(context)..pop()..pop();

                            },
                            child: const Text('ONAYLA'),
                          )),
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)))),
                  child: const Text('Sil'),
                ),
              ),
            ],
          ),
        ));
  }
}
