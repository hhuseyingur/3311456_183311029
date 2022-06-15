import 'package:bunudaoku/models/Gazete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GazeteDuzenle extends StatelessWidget {
  GazeteDuzenle({Key? key, required this.gazete}) : super(key: key);
  final Gazete? gazete;
  final adController = TextEditingController();
  final noController = TextEditingController();

  clearText() {
    adController.clear();
    noController.clear();
  }

  CollectionReference gazeteler =
      FirebaseFirestore.instance.collection('gazeteler');

  Future<void> updateGazete() {
    gazete?.gazeteadi = adController.text;
    gazete?.gazeteno = noController.text;
    return gazeteler
        .doc(gazete?.gazeteid)
        .update(gazete!.toJson())
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Kitap Başarıyla Eklendi",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white70,
                  fontSize: 16.0),
              print("Kitap Güncellendi")
            })
        .catchError((error) => {
              Fluttertoast.showToast(
                  msg: "Bir Hata Oluştu $error",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white70,
                  fontSize: 16.0),
              print('Hata oluştu: $error')
            });
  }

  @override
  Widget build(BuildContext context) {
    adController.text = gazete!.gazeteadi;
    noController.text = gazete!.gazeteno;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gazete Düzenle"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Gazete Adı: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: adController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gazete Adı Girin';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'No: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: noController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gazete No Girin';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updateGazete();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Gazete Düzenle',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => {clearText()},
                    child: const Text(
                      'Temizle/İptal',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
