import 'package:bunudaoku/models/Kitap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class KitapDuzenle extends StatelessWidget {
  KitapDuzenle({Key? key, required this.kitap, this.kitapid}) : super(key:key);
  final Kitap? kitap;
  final kitapid;
  final adController = TextEditingController();
  final yazarController = TextEditingController();
  final ozetController = TextEditingController();

  clearText(){
    adController.clear();
    yazarController.clear();
    ozetController.clear();
  }

  CollectionReference kitaplar = FirebaseFirestore.instance.collection('kitaplar');

  Future<void> updateKitap(){
    kitap?.kitapozet = ozetController.text;
    kitap?.kitapyazar = yazarController.text;
    kitap?.kitapadi = adController.text;
    return kitaplar
        .doc(kitap?.kitapid)
        .update(kitap!.toJson())
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
        .catchError((error)=> {
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
    adController.text = kitap!.kitapadi;
    yazarController.text = kitap!.kitapyazar;
    ozetController.text = kitap!.kitapozet;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kitap Düzenle"),
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
                    labelText: 'Kitap Adı: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: adController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kitap Adı Girin';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Yazar: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                    TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: yazarController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kitap Yazarı Girin';
                    }
                    return null;
                  },
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
                      return 'Özet Girin';
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                          updateKitap();
                    },
                    child: const Text(
                      'Kitap Düzenle',
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