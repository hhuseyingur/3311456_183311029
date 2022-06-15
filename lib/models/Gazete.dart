class Gazete {
  String? gazeteid;
  String gazeteadi;
  String gazeteno;

  Gazete({required this.gazeteadi, required this.gazeteno, this.gazeteid});

  Map<String, dynamic> toJson() => {
        'gazeteadi': gazeteadi,
        'gazeteno': gazeteno,
      };

  factory Gazete.fromJson({required Map<String, dynamic> map}) {
    return Gazete(
      gazeteadi: map['gazeteadi'],
      gazeteno: map['gazeteno'],
      gazeteid: map['id'],
    );
  }
}
