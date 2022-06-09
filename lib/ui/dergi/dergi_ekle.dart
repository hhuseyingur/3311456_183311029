import 'package:bunudaoku/models/Dergi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';


class DergiEkle extends StatefulWidget {
  const DergiEkle({Key? key}) : super(key: key);

  @override
  State<DergiEkle> createState() => _DergiEkleState();
}

class _DergiEkleState extends State<DergiEkle> {

  final _formKey = GlobalKey<FormState>();
  final adController = TextEditingController();
  final sayiController = TextEditingController();
  final ozetController = TextEditingController();
  /*
    var dergiAd = "";
    var dergiSayi = "";
    var dergiOzet = "";
   */
  clearText(){
    adController.clear();
    sayiController.clear();
    ozetController.clear();

  }

  @override
  void dispose(){
    adController.dispose();
    sayiController.dispose();
    ozetController.dispose();
    super.dispose();
  }

  CollectionReference dergiler = FirebaseFirestore.instance.collection('dergiler');

  Future<void> addDergi(){
    var dergi = Dergi(adController.text, ozetController.text, sayiController.text);
    //print(dergi);
    //print(jsonEncode(dergi));
    return dergiler.add(dergi.toJson())
        .then((value) => Fluttertoast.showToast(
        msg: 'Dergi Başarıyla Eklendi',
    toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white70,
      fontSize: 16.0).catchError((error)=>
        Fluttertoast.showToast(
            msg: "Bir Hata Oluştu $error",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white70,
            fontSize: 16.0)));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dergi Ekle'),
        ),
        body: Form(
    key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Dergi Adı: ',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                        color: Colors.redAccent,
                          fontSize: 15
                      ),
                    ),
                    controller: adController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Dergi Adı Girin';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Dergi Sayi: ',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15
                      ),
                    ),
                    controller: sayiController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Dergi Sayısı Girin';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    autofocus: false,
                    decoration: const InputDecoration(
                      labelText: 'Özet Adı: ',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15
                      ),
                    ),
                    controller: ozetController,
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Dergi Özeti Girin';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          addDergi();
                          clearText();
                        });
                      }
                    }, child: const Text(
                      'Dergi Ekle',
                      style: TextStyle(fontSize: 18.0),
                    )
                    ),
                    ElevatedButton(onPressed: ()=> clearText(),
                      style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                      child: const Text(
                          'Temizle / İptal',
                          style: TextStyle(fontSize: 18.0),
                        ),

                    )
                  ],
                )


              ],
            ),
          ),
    ));
  }
}
