class Usuario {
  String nombreUsuario;
  String password;
  bool esAdmin;
  String nombre;

  Usuario(this.nombreUsuario, this.nombre,
      {this.esAdmin = false, this.password = "0"});
}
