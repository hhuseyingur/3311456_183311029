
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
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
              child: buildImage(),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                children: [
                  Text("Kullanıcı Adı"),
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
  Widget buildImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.blue,
        backgroundImage: const NetworkImage(
            'https://www.nicepng.com/png/full/128-1280406_view-user-icon-png-user-circle-icon-png.png'),
      );
}
