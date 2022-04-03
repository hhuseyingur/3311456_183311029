import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'kitap_ekle_cikti.dart';

TextEditingController adController = TextEditingController();
TextEditingController yazarController = TextEditingController();
late String ad, yazar;

class KitapEkle extends StatefulWidget {
  const KitapEkle({Key? key}) : super(key: key);

  @override
  State<KitapEkle> createState() => _KitapEkleState();
}

class _KitapEkleState extends State<KitapEkle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Kitaplar'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: (text) {
              ad = text;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Kitap Adını Giriniz',
            ),
            controller: adController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (text) {
              yazar = text;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Kitap Yazarını Giriniz',
            ),
            controller: yazarController,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null;
                  },
                ),
              ),
              onPressed: () {
                if (formControl() == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Lütfen tüm alanları doldurunuz!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KitapEkleCikti(
                        ad: '$ad',
                        yazar: '$yazar',
                      ),
                    ),
                  );
                }
              },
              child: Text('Kitap Ekle')),
        ])));
  }

  bool formControl() {
    var adControl = adController.text;
    var yazarControl = yazarController.text;
    if (adControl.isEmpty && yazarControl.isEmpty) {
      return false;
    }
    return true;
  }
}
