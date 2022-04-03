
import 'package:bunudaoku/ui/kitap/kitap_ekle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kitap.dart';

class KitapEkleCikti extends StatefulWidget {
  final String ad, yazar;
  const KitapEkleCikti({required this.ad, required this.yazar, Key? key})
      : super(key: key);

  @override
  State<KitapEkleCikti> createState() => _KitapEkleCiktiState();
}

class _KitapEkleCiktiState extends State<KitapEkleCikti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eklenen Kitap'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text("Eklenencek Kitabın \n\nAdı: $ad \n\nYazarı: $yazar",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                )),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KitapSayfa(),
                    ),
                  );
                },
                child: const Text('Kitap Listesine Geri Dön'),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
