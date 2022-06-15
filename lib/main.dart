import 'package:bunudaoku/home.dart';
import 'package:bunudaoku/shared_preferences.dart/auth_sp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'login/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AuthStorage.isAuth().then((isAuth) {
    runApp(MyApp(
      isAuth: isAuth ?? false,
    ));
  });
}

class MyApp extends StatelessWidget {
  bool isAuth;
  MyApp({Key? key, required this.isAuth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bunudaoku',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: isAuth ? MyHomePage() : const LoginPage(),
    );
  }
}
