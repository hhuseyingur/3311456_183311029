import 'dart:convert';

class Kullanici {
  int? id;
  String email;
  String password;
  String? name;
  String? lastName;
  String? imgPath;

  Kullanici({
    this.id,
    required this.email,
    required this.password,
    this.name,
    this.lastName,
    this.imgPath,
  });

  String toJson() {
    Map map = {
      "email": email,
      "password": password,
      "name": name,
      "lastName": lastName,
      "imgPath": imgPath
    };
    return jsonEncode(map);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "email": email,
      "password": password,
      "name": name,
      "lastName": lastName,
      "imgPath": imgPath
    };
    return map;
  }

  factory Kullanici.fromJson({required Map<String, dynamic> map}) {
    return Kullanici(
      id: map['id'],
      email: map['email'],
      password: map['password'],
      name: map['name'],
      lastName: map['lastName'],
      imgPath: map['imgPath'],
    );
  }

  Kullanici copy({
    int? id,
    String? email,
    String? password,
    String? name,
    String? lastName,
    String? imgPath,
  }) =>
      Kullanici(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        imgPath: imgPath ?? this.imgPath,
      );
}
