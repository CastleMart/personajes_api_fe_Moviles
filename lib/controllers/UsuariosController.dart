import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import "package:http/http.dart" as http;

class UsuariosController {
  static String _urlEndpoint =
      "https://bh4aaegaea.execute-api.us-east-1.amazonaws.com/test/";

  static bool _esAdmin = false;

  ///Método que regresa un usuario disponibles en la API.
  ///
  ///Devuelve como resultado [Usuario]
  Future<Usuario> getUsuario(String NombreUsuario) async {
    Usuario usuario;
    var url = Uri.parse(_urlEndpoint + NombreUsuario);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      usuario = Usuario(jsonData["NombreUsuario"], jsonData["Nombre"],
          esAdmin: jsonData["Administrador"]);
    } else {
      return throw Exception("Falló la conexión.");
    }

    return usuario;
  }

  crearUsuario(Usuario usuario, context) async {
    var url = Uri.parse(_urlEndpoint);
    var body = {
      "NombreUsuario": usuario.nombreUsuario,
      "Nombre": usuario.nombre,
      "Password": usuario.password
    };
    var response = await http.post(url, body: jsonEncode(body));

    return response;
  }

  Future<bool> verificarPassword(String nombreUsuario, String password) async {
    var url = Uri.parse(_urlEndpoint + nombreUsuario);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      _esAdmin = jsonData["Administrador"];
      return jsonData["Password"] == password;
    }

    return false;
  }

  static Future<bool> existeUsuario(String nombreUsuario) async {
    var url = Uri.parse(_urlEndpoint + nombreUsuario);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData["NombreUsuario"] == nombreUsuario;
    }
    return false;
  }

  bool getEsAdmin() {
    return _esAdmin;
  }
}
