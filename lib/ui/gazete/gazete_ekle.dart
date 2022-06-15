import 'package:bunudaoku/models/Gazete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GazeteEkle extends StatefulWidget {
  const GazeteEkle({Key? key}) : super(key: key);

  @override
  State<GazeteEkle> createState() => _GazeteEkleState();
}

class _GazeteEkleState extends State<GazeteEkle> {

  final _formKey = GlobalKey<FormState>();
  final adController = TextEditingController();
  final noController = TextEditingController();

  clearText(){
    adController.clear();
    noController.clear();
  }

  @override
  void dispose(){
    adController.dispose();
    noController.dispose();
    super.dispose();
  }

  CollectionReference gazeteler = FirebaseFirestore.instance.collection('gazeteler');

  Future<void> addGazete(){
    Gazete  gazete = Gazete(gazeteadi: adController.text, gazeteno: noController.text);

    return gazeteler.add(gazete.toJson())
        .then((value) => Fluttertoast.showToast(
        msg: 'Gazete Başarıyla Eklendi',
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
        title: const Text('Gazete Ekle'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Gazete Adı: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border:  OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15
                    )
                  ),
                  controller: adController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Gazete adı girin';
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
                    labelText: 'Gazete No',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 15
                    ),
                  ),
                  controller: noController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return 'Gazete numrasını Girin';
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
                        addGazete();
                        clearText();
                        Navigator.pop(context);
                      });
                    }
                  }, child: const Text(
                    'Gazete Ekle',
                    style: TextStyle(fontSize: 18.0),
                  )
                  ),
                  ElevatedButton(onPressed: clearText,
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
      ),
    );
  }
}
