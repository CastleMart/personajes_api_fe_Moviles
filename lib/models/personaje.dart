class Personaje {
  String id;
  String nombre;
  String fuerza;
  String defenza;
  String img;
  bool favorito;
  String imgPixel;
  //List<String> apariciones;

  Personaje(
      this.id, this.nombre, this.fuerza, this.defenza, this.img, this.favorito,
      {this.imgPixel =
          "https://th.bing.com/th/id/OIP.Irfnpa7yJAOq-XdVryE5dwHaHa?pid=ImgDet&rs=1"});
}
