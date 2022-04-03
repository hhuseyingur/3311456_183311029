
import 'package:bunudaoku/ui/dergi/dergi.dart';
import 'package:bunudaoku/ui/gazete/gazete.dart';
import 'package:bunudaoku/ui/kitap/kitap.dart';
import 'package:bunudaoku/ui/profil/profil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState();

  int chosenMenuItem = 0;
  late List<Widget> allPages;
  late KitapSayfa kitapSayfa;
  late DergiSayfa dergiSayfa;
  late GazeteSayfa gazeteSayfa;
  late ProfilSayfa profilSayfa;

  var keyKitapSayfa = const PageStorageKey('kitap_sayfa');
  var keyDergiSayfa = const PageStorageKey('dergi_sayfa');
  var keyGazeteSayfa = const PageStorageKey('gazete_sayfa');
  var keyProfilSayfa = const PageStorageKey('profil_sayfa');

  @override
  void initState() {
    super.initState();

    kitapSayfa = KitapSayfa(key: keyKitapSayfa);
    dergiSayfa = DergiSayfa(key: keyDergiSayfa);
    gazeteSayfa = GazeteSayfa(key: keyGazeteSayfa);
    profilSayfa = ProfilSayfa(key: keyProfilSayfa);
    allPages = [kitapSayfa, dergiSayfa, gazeteSayfa, profilSayfa];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chosenMenuItem <= allPages.length - 1
          ? allPages[chosenMenuItem]
          : allPages[0],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  Theme bottomNavMenu() {
    return Theme(
      data: ThemeData(
          canvasColor: Colors.cyan.shade100, primaryColor: Colors.orangeAccent),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Kitap',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Dergi',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.art_track),
              label: 'Gazete',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profil',
              backgroundColor: Colors.blue),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: chosenMenuItem,
        onTap: (index) {
          setState(() {
            chosenMenuItem = index;
          });
        },
      ),
    );
  }
}
