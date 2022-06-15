
import 'package:flutter/material.dart';

import 'gazete_ekle.dart';
import 'gazete_listele.dart';

class GazeteSayfa extends StatefulWidget {
  const GazeteSayfa({Key? key}) : super(key: key);

  @override
  State<GazeteSayfa> createState() => _GazeteSayfaState();
}

class _GazeteSayfaState extends State<GazeteSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gazeteler'),
      ),
      body: const GazeteListele(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GazeteEkle(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
