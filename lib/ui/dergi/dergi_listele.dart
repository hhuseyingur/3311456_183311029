import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DergiListele extends StatefulWidget {
  const DergiListele({Key? key}) : super(key: key);

  @override
  State<DergiListele> createState() => _DergiListeleState();
}

class _DergiListeleState extends State<DergiListele> {
  @override
  Widget build(BuildContext context) {
    var dergiListe = [
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Dergi Adı 1'),
        subtitle: Text('Dergi No : 1'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Dergi Adı 2'),
        subtitle: Text('Dergi No : 2'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Dergi Adı 3'),
        subtitle: Text('Dergi No : 3'),
      ),
    ];
    return Scaffold(
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: dergiListe.length,
            itemBuilder: (context, index) {
              var dergiList = dergiListe[index];
              return dergiList;
            }),
      ),
    );
  }
}
