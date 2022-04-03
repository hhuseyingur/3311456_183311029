import 'package:flutter/material.dart';

class DergiEkle extends StatefulWidget {
  const DergiEkle({Key? key}) : super(key: key);

  @override
  State<DergiEkle> createState() => _DergiEkleState();
}

class _DergiEkleState extends State<DergiEkle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dergi Ekle'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Dergi Adını Giriniz',
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            color: Colors.blueAccent,
            child: Text(
              "Dergi Ekle",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {},
          )
        ])));
  }
}
