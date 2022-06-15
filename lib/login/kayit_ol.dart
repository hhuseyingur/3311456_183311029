import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/Kullanici.dart';
import 'login.dart';

class KayitOl extends StatefulWidget {
  const KayitOl({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _KayitOl();
}

class _KayitOl extends State<KayitOl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
      body: KayitOlIcerik(),
      bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Hasan Hüseyin Gür",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}

class KayitOlIcerik extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _KayitOlIcerik();
}

class _KayitOlIcerik extends State<KayitOlIcerik> {
  bool _isVisible = false;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  String returnVisibilityString = "";
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final sifre1Controller = TextEditingController();
  final sifre2Controller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future kayitOl() async {

    if(sifre1Controller.text == sifre2Controller.text){
      var user = Kullanici(email: mailController.text,password: sifre1Controller.text);
      try {

        final authresult = await _auth.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
              (Route<dynamic> route) => false,
        );
      } on FirebaseAuthException catch (e) {

        print("AUTH HATA" + e.toString());
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: "ŞİFRE ZAYIF",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white70,
              fontSize: 16.0);
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: "EMAİL KULLANIMDA",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white70,
              fontSize: 16.0);
        }
        mailController.clear();
      } catch (e) {
        print("AUTH HATA" + e.toString());
      }


    }
    else {
      Fluttertoast.showToast(
          msg: "ŞİFRELER EŞLEŞMİYOR",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white70,
          fontSize: 16.0);
      Timer(Duration(milliseconds: 700), () {
        sifre1Controller.clear();
        sifre2Controller.clear();
      });
    }
  }

  @override
  void dispose(){
    mailController.dispose();
    sifre1Controller.dispose();
    sifre2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30.5,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                "Kayıt Ol",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 390,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child:Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value)=> EmailValidator.validate(value!) ? null: "Mail Yanlış",
                    controller: mailController,
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(15)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    controller: sifre1Controller,
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Şifre",
                        contentPadding: EdgeInsets.all(20),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure1
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure1 = !_isObscure1;
                            });
                          },
                        )),
                    obscureText: _isObscure1,
                  ),
                  FlutterPwValidator(width: 400, height: 150,
                      onSuccess: ()=>{},
                      onFail:()=>{} ,
                      controller: sifre1Controller,
                      minLength: 10,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                  ),
                  Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    controller: sifre2Controller,
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },

                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Şifre Tekrarı",
                        contentPadding: EdgeInsets.all(20),
                        suffixIcon: IconButton(
                          icon: Icon(_isObscure2
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          },
                        )),
                    obscureText: _isObscure2,
                  ),
                ],
              ),
            )



          ),
          Container(
            width: 570,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: RaisedButton(
                color: Colors.pink,
                child: Text("Kayıt Ol", style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () async {
                  if(_formKey.currentState!.validate())
                    {
                      kayitOl();
                    }
                  else{
                    Fluttertoast.showToast(
                        msg: "BİLGİLERİ DOĞRU GİRİN",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white70,
                        fontSize: 16.0);
                  }

                }),
          ),
        ],
      ),
    );
  }
}