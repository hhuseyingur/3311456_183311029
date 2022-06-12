class Gazete {
  String gazeteadi;
  String gazeteno;

  Gazete(this.gazeteadi,this.gazeteno);

  Map<String, dynamic> toJson()=>{
    'gazeteadi': gazeteadi,
    'gazeteno': gazeteno
  };
}