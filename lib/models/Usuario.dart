class Usuario {
  String nombreUsuario;
  String password;
  bool esAdmin;
  String nombre;
  List<String?> favoritos = [];

  Usuario(this.nombreUsuario, this.nombre,
      {this.favoritos = const [], this.esAdmin = false, this.password = "0"});
}
