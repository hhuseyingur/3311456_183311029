import 'dart:convert';

import 'package:bunudaoku/models/Kullanici.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static Future<SharedPreferences> futureAuthSP =
      SharedPreferences.getInstance();

  static Future<void> sessionOn({required Kullanici kullanici}) async {
    SharedPreferences authSP = await futureAuthSP;
    authSP.setString("authUser", jsonEncode(kullanici.toMap()));
    authSP.setBool("isAuth", true);
  }

  static Future<Kullanici?> getAuthUser() async {
    SharedPreferences authSP = await futureAuthSP;
    String? authUser = authSP.getString("authUser");
    if (authUser != null) {
      return Kullanici.fromJson(map: jsonDecode(authUser));
    }
    return null;
  }

  static Future<bool?> isAuth() async {
    SharedPreferences authSP = await futureAuthSP;
    bool? isAuth = authSP.getBool("isAuth");
    return isAuth;
  }

  static void sessionOff() async {
    SharedPreferences authSP = await futureAuthSP;
    authSP.remove("authUser");
    authSP.remove("isAuth");
  }
}
