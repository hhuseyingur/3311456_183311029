import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'kitap_ekle_cikti.dart';


class KitapEkle extends StatefulWidget {
  const KitapEkle({Key? key}) : super(key: key);

  @override
  State<KitapEkle> createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {

  final _formKey = GlobalKey<FormState>();
  final adController = TextEditingController();
  final yazarController = TextEditingController();
  final ozetController = TextEditingController();
  var kitapAdi = "";
  var kitapYazar = "";
  var kitapOzet = "";
  

  
  @override
  void dispose(){
    adController.dispose();
    yazarController.dispose();
    ozetController.dispose();
    super.dispose();
  }
  
  clearText(){
    adController.clear();
    yazarController.clear();
    ozetController.clear();
  }
  
  CollectionReference kitaplar = FirebaseFirestore.instance.collection('kitaplar');

  Future<void> addKitap(){
    return kitaplar.add(
        {'kitapadi':kitapAdi, 'kitapozet':kitapOzet,'kitapyazar':kitapYazar})
        .then((value) => {
          Fluttertoast.showToast(
            msg: "Kitap Başarıyla Eklendi",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white70,
          fontSize: 16.0),
          print("Kitap Eklendi")
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yeni Kitap Ekle"),
      ),
      body: Form(
        key: _formKey,
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
                  obscureText: true,
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
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          kitapAdi = adController.text;
                          kitapYazar = yazarController.text;
                          kitapOzet = ozetController.text;
                          addKitap();
                          clearText();
                        });
                      }
                    },
                    child: const Text(
                      'Kitap Ekle',
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

  bool formControl() {
    var adControl = adController.text;
    var yazarControl = yazarController.text;
    if (adControl.isEmpty && yazarControl.isEmpty) {
      return false;
    }
    return true;
  }
}
