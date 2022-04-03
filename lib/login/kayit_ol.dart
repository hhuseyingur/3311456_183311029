import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 37.5,
            width: 400,
          ),
          Center(
            child: Container(
              height: 245,
              width: 400,
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
            height: 215,
            width: 530,
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
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Kullanıcı Adı",
                      contentPadding: EdgeInsets.all(20)),
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
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
                Divider(
                  thickness: 3,
                ),
                TextFormField(
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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                }),
          ),
        ],
      ),
    );
  }
}