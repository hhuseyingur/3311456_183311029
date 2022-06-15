import 'package:bunudaoku/models/Dergi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DergiDuzenle extends StatelessWidget {
  DergiDuzenle({Key? key, required this.dergi}) : super(key: key);
  final Dergi dergi;
  final adController = TextEditingController();
  final sayiController = TextEditingController();
  final ozetController = TextEditingController();

  clearText() {
    adController.clear();
    sayiController.clear();
    ozetController.clear();
  }

  CollectionReference dergiler =
      FirebaseFirestore.instance.collection('dergiler');

  Future<void> updateDergi() {
    dergi.dergiadi = adController.text;
    dergi.dergisayi = sayiController.text;
    dergi.dergiozet = ozetController.text;
    return dergiler
        .doc(dergi.id)
        .update(dergi.toJson())
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Dergi Başarıyla Eklendi",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white70,
                  fontSize: 16.0),
              print("Dergi Güncellendi")
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
    adController.text = dergi.dergiadi;
    sayiController.text = dergi.dergisayi;
    ozetController.text = dergi.dergiozet;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dergi Düzenle"),
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
                    labelText: 'Dergi Adı: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: adController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dergi Adı Girin';
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
                    labelText: 'Sayı: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: sayiController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dergi Sayı Girin';
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
                    labelText: 'Özet: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: ozetController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Dergi Özet Girin';
                    }
                    return null;
                  },
                  maxLines: 10,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      updateDergi();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Dergi Düzenle',
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
