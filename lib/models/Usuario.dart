///Clase usuario que sirve como modelo para un usuario en específico.
class Usuario {
  String nombreUsuario;
  String password;
  bool esAdmin;
  String nombre;
  List<String> favoritos = [];

  Usuario(this.nombreUsuario, this.nombre,
      {this.favoritos = const [], this.esAdmin = false, this.password = "0"});
}
