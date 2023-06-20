import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import "package:http/http.dart" as http;

///Controlador de las peticiones de los usuarios realizadas con la API
class UsuariosController {
  static String _urlEndpoint =
      "https://bh4aaegaea.execute-api.us-east-1.amazonaws.com/test/";

  static bool _esAdmin = false;

  ///Método que regresa un usuario disponible en la API.
  ///
  ///Recibe el [NombreUsuario] para devolver sus atributos.
  ///
  ///Devuelve como resultado [Usuario]
  Future<Usuario> getUsuario(String NombreUsuario) async {
    Usuario usuario;
    var url = Uri.parse(_urlEndpoint + NombreUsuario);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      usuario = Usuario(jsonData["NombreUsuario"], jsonData["Nombre"],
          favoritos: List<String>.from(jsonData['Favoritos']),
          esAdmin: jsonData["Administrador"]);
    } else {
      return throw Exception("Falló la conexión.");
    }

    return usuario;
  }

  ///Método post que recibe un [Usuario]
  ///
  ///Este método devolverá la respuesta de la petición.
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

  ///Método que verifica si el [nombreUsuario], [password] que recibe, concuerda con lo
  ///que se tiene en la API para iniciar sesión.
  ///
  ///Este método devuelve un [Future] de tipo [bool].
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

  static bool getEsAdmin() {
    return _esAdmin;
  }

  ///Método put que recibe [nombreUsuario] y una [List] de los identificadores
  ///de los personajes que le gusta al usuario.
  ///
  ///Este método actualizará los personajes favoritos en la API y devolverá la respuesta.
  static putFavoritos(String nombreUsuario, List<String> idPersonajes) async {
    var url = Uri.parse(_urlEndpoint);
    var body = {"NombreUsuario": nombreUsuario, "Favoritos": idPersonajes};
    var response = await http.put(url, body: jsonEncode(body));
    return response;
  }
}
