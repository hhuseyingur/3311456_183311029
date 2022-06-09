class Dergi {
   String dergiadi;
   String dergiozet;
   String dergisayi;
  Dergi(this.dergiadi,this.dergiozet,this.dergisayi);

   Map<String, dynamic> toJson() => {
     'dergiadi': dergiadi,
     'dergiozet': dergiozet,
     'dergisayi' : dergisayi
   };
}