class Dergi {
  String dergiadi;
  String dergiozet;
  String dergisayi;
  String? id;

  Dergi({
    required this.dergiadi,
    required this.dergiozet,
    required this.dergisayi,
    this.id,
  });

  Map<String, dynamic> toJson() =>
      {'dergiadi': dergiadi, 'dergiozet': dergiozet, 'dergisayi': dergisayi};

  factory Dergi.fromJson({required Map<String, dynamic> map}) {
    return Dergi(
      dergiadi: map['dergiadi'],
      dergiozet: map['dergiozet'],
      dergisayi: map['dergisayi'],
      id: map['id'],
    );
  }
}
