import 'dart:io';

import 'package:bunudaoku/db/userdao.dart';
import 'package:bunudaoku/models/Kullanici.dart';
import 'package:bunudaoku/shared_preferences.dart/auth_sp.dart';
import 'package:bunudaoku/ui/profil/profil_duzenle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../login/login.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({Key? key}) : super(key: key);

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {
  Kullanici? kullanici;
  String? name;
  String? lastName;
  String? imgPath;

  kullaniciGetir() async {
    final Kullanici? gelenKullanici = await UserDao.kullaniciGetir();
    if (gelenKullanici != null) {
      setState(() {
        kullanici = gelenKullanici;
        name = gelenKullanici.name;
        lastName = gelenKullanici.lastName;
        imgPath = gelenKullanici.imgPath;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //kullaniciGetir();
  }

  @override
  Widget build(BuildContext context) {
    kullaniciGetir();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  AuthStorage.sessionOff();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.blue,
                )),
          ],
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: buildImage(imgPath: imgPath),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: [
                  Text((name ?? "Ad girilmemiş") + " " + (lastName ?? "")),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity / 1.2,
              child: Container(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilDuzenle(),
                    ),
                  );
                },
                child: const Text('Profil Bilgilerini Düzenle'),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }

  final double profileHeight = 144;

  Widget buildImage({String? imgPath}) {
    return CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.blue,
      backgroundImage: imgPath == null
          ? const NetworkImage(
              'https://www.nicepng.com/png/full/128-1280406_view-user-icon-png-user-circle-icon-png.png')
          : null,
      child: imgPath == null
          ? null
          : ClipOval(
              child: Image.file(
                File(imgPath),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
