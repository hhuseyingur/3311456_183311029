// ignore: file_names
import 'package:flutter/material.dart';

class KitapListele extends StatefulWidget {
  const KitapListele({Key? key}) : super(key: key);

  @override
  State<KitapListele> createState() => _KitapListeleState();
}

class _KitapListeleState extends State<KitapListele> {
  @override
  Widget build(BuildContext context) {
    var kitapListe = [
      const ListTile(
        //onTap:() {},
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Kitap 1'),
        subtitle: Text('Yazar : Yazar 1'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Kitap 2'),
        subtitle: Text('Yazar : Yazar 2'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Kitap 3'),
        subtitle: Text('Yazar : Yazar 3'),
      ),
    ];
    return Scaffold(
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: kitapListe.length,
            itemBuilder: (context, index) {
              var kitapList = kitapListe[index];
              return kitapList;
            }),
      ),
    );
  }
}
