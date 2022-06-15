import 'package:bunudaoku/models/Kullanici.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

class UserDao {
  static Future<Kullanici?> kullaniciGetir() async {
    Database db = await VeritabaniYardimcisi.veritabaniErisim();
    final List<Map<String, Object?>> result = await db.query("user", limit: 1);
    if (result.isNotEmpty) {
      return Kullanici.fromJson(map: result.first);
    }
    return null;
  }

  static Future<Kullanici> kullaniciEkle({required Kullanici kullanici}) async {
    Database db = await VeritabaniYardimcisi.veritabaniErisim();
    final int id = await db.insert("user", kullanici.toMap());
    debugPrint(id.toString());
    return kullanici.copy(id: id);
  }

  static Future<Kullanici> kullaniciGuncelle(
      {required Kullanici kullanici}) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.update("user", kullanici.toMap(),
        where: "id=?", whereArgs: [kullanici.id]);
    return kullanici;
  }

  static Future<int> kullaniciSil({required int kullaniciid}) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    final id = await db.delete("user", where: "id=?", whereArgs: [kullaniciid]);
    debugPrint(id.toString());
    return id;
  }
}
