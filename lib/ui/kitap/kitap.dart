import 'package:bunudaoku/ui/kitap/kitap_listelee.dart';
import 'package:flutter/material.dart';

import 'kitap_ekle.dart';
import 'kitap_listele.dart';

class KitapSayfa extends StatefulWidget {
  const KitapSayfa({Key? key}) : super(key: key);

  @override
  State<KitapSayfa> createState() => _KitapSayfaState();
}

class _KitapSayfaState extends State<KitapSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitaplar'),
      ),
      body: const KitapListelee(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const KitapEkle(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
