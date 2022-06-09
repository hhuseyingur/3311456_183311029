import 'package:flutter/material.dart';

class GazeteListele extends StatefulWidget {
  const GazeteListele({Key? key}) : super(key: key);

  @override
  State<GazeteListele> createState() => _GazeteListeleState();
}

class _GazeteListeleState extends State<GazeteListele> {
  @override
  Widget build(BuildContext context) {
    var gazeteListe = [
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Gazete Adı 1'),
        subtitle: Text('Gazete No : 1'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Gazete Adı 2'),
        subtitle: Text('Gazete No : 2'),
      ),
      const ListTile(
        contentPadding: EdgeInsets.all(5),
        tileColor: Colors.lightBlueAccent,
        title: Text('Gazete Adı 3'),
        subtitle: Text('Gazete No : 3'),
      ),
    ];
    return Scaffold(
      body: Center(
        child: ListView.builder(
            padding: const EdgeInsets.all(5),
            itemCount: gazeteListe.length,
            itemBuilder: (context, index) {
              var gazeteList = gazeteListe[index];
              return gazeteList;
            }),
      ),
    );
  }
}