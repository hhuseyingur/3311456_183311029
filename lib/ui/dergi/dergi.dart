
import 'package:flutter/material.dart';

import 'dergi_ekle.dart';
import 'dergi_listele.dart';

class DergiSayfa extends StatefulWidget {
  const DergiSayfa({Key? key}) : super(key: key);

  @override
  State<DergiSayfa> createState() => _DergiSayfaState();
}

class _DergiSayfaState extends State<DergiSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dergiler'),
      ),
      body: const DergiListele(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DergiEkle(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
