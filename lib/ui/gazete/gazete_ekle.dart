import 'package:flutter/material.dart';

class GazeteEkle extends StatefulWidget {
  const GazeteEkle({Key? key}) : super(key: key);

  @override
  State<GazeteEkle> createState() => _GazeteEkleState();
}

class _GazeteEkleState extends State<GazeteEkle> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Gazete Ekle'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Gazete Adını Giriniz',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Gazete Numarası Giriniz',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: style,
            onPressed: () {},
            child: const Text('Gazete Ekle'),
          ),
        ])));
  }
}
