import 'package:flutter/cupertino.dart';

class Kitap {
  String kitapadi;
  String kitapyazar;
  String kitapozet;
  String? kitapid;
  Kitap({required this.kitapadi, required this.kitapozet,required this.kitapyazar,this.kitapid});

  Map<String, dynamic> toJson() => {
    'kitapadi': kitapadi,
    'kitapozet': kitapozet,
    'kitapyazar' : kitapyazar
  };
}