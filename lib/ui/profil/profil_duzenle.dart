import 'package:flutter/material.dart';

class ProfilDuzenle extends StatelessWidget {
  const ProfilDuzenle({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil Bilgilerini Düzenle'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Adınızı Giriniz',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Soyadınızı Giriniz',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity / 1.2,
            child: Container(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
              onPressed: () {},
              child: const Text('Düzenle'),
            ),
            ),
          ),
        ])));
  }
}