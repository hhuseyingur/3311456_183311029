import 'package:bunudaoku/models/Kullanici.dart';
import 'package:bunudaoku/shared_preferences.dart/auth_sp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home.dart';
import 'kayit_ol.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Giriş Yap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SanFrancisco',
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color.fromRGBO(40, 38, 56, 1),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://mir-s3-cdn-cf.behance.net/project_modules/disp/496ecb14589707.562865d064f9e.png"),
                  fit: BoxFit.cover)),
          child: LoginScreen(),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: SizedBox(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Hasan Hüseyin Gür",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 0,
                width: 0,
              ),
              Center(
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Text(
                    "Bunudaoku",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
                width: 10,
              ),
              Visibility(
                visible: _isVisible,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Lütfen Boş Alan Bırakmayınız!",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      controller: usernameController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          contentPadding: EdgeInsets.all(20)),
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                    ),
                    Divider(
                      thickness: 3,
                    ),
                    TextFormField(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Şifre",
                          contentPadding: EdgeInsets.all(20),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )),
                      obscureText: _isObscure,
                    ),
                  ],
                ),
              ),
              Container(
                width: 570,
                height: 70,
                padding: const EdgeInsets.only(top: 20),
                child: loading == true
                    ? const SizedBox(
                        width: 50, child: CircularProgressIndicator())
                    : RaisedButton(
                        color: Colors.pink,
                        child: const Text("Giriş Yap",
                            style: TextStyle(color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            final credentials = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: usernameController.text,
                                    password: passwordController.text);
                            AuthStorage.sessionOn(
                                kullanici: Kullanici(
                                    email: usernameController.text,
                                    password: passwordController.text));
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                              (Route<dynamic> route) => false,
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "user-not-found") {
                              Fluttertoast.showToast(
                                  msg: "Kullanıcı Bulunamadı",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white70,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Şifre Yanlış",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white70,
                                  fontSize: 16.0);
                            }
                            print(e);
                          }
                          setState(() {
                            loading = false;
                          });
                        }),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                  child: Center(
                      child: RichText(
                    text: TextSpan(
                      text: "Hesabınız yok mu? ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                            text: " Kayıt Ol",
                            style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const KayitOl()),
                                    )
                                  }),
                      ],
                    ),
                  )))
            ],
          )),
    );
  }
}
