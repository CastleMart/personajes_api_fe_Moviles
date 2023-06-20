import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/main.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import "package:http/http.dart" as http;

///Contolador de los diferentes métodos de peticiones de API.
class PersonajeController {
  static const String _urlEndpoint =
      'https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test/';

  ///Método que regresa todos los personajes disponibles en la API.
  ///
  ///Devuelve como resultado [personajes]
  Future<List<Personaje>> getPersonajes() async {
    List<Personaje> personajes = [];
    var url = Uri.parse(_urlEndpoint);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      personajes = [];
      final jsonData = await jsonDecode(response.body);

      for (var item in jsonData) {
        personajes.add(Personaje(item["idPersonaje"], item["Nombre"],
            item["Fuerza"], item["Defenza"], item["Img"], item["Favorito"],
            imgPixel: item["ImgPixel"]));
      }
    } else {
      throw Exception("Falló la conexión.");
    }

    return personajes;
  }

  /// Obtiene un personaje por su id.
  ///
  /// [id] es el id del personaje que se quiere obtener.
  ///
  /// Retorna un objeto de tipo [Personaje]
  static Future<Personaje> getPersonajeId(String id) async {
    var url = Uri.parse(_urlEndpoint + id);
    var response = await http.get(url);

    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Personaje personaje = Personaje(
          jsonData["idPersonaje"],
          jsonData["Nombre"],
          jsonData["Fuerza"],
          jsonData["Defenza"],
          jsonData["Img"],
          jsonData["Favorito"],
          imgPixel: jsonData["ImgPixel"]);
      return personaje;
    } else {
      return throw Exception("Falló la conexión.");
    }
  }

  /// Método para crear un personaje.
  ///
  /// Recibe un objeto [personaje] para ingresar en la API.
  ///
  /// Retorna la respuesta que arroje el servidor
  crearPersonaje(Personaje personaje, context) async {
    var url = Uri.parse(_urlEndpoint);
    var body = {
      "idPersonaje": personaje.id,
      "Defenza": personaje.defensa,
      "Nombre": personaje.nombre,
      "Fuerza": personaje.fuerza,
      "Img": personaje.img,
      "ImgPixel": personaje.imgPixel
    };
    var response = await http.post(url, body: jsonEncode(body));

    return response;
  }

  /// Método que actualiza un personaje.
  ///
  /// Recibe un objeto [personaje] para actualizar en la API.
  ///
  /// Retorna la respuesta que arroje el servidor
  actualizarPersonaje(Personaje personaje, context) async {
    var url = Uri.parse(_urlEndpoint);
    var body = {
      "idPersonaje": personaje.id,
      "Defenza": personaje.defensa,
      "Nombre": personaje.nombre,
      "Fuerza": personaje.fuerza,
      "Img": personaje.img,
      "ImgPixel": personaje.imgPixel
    };
    var response = await http.put(url, body: jsonEncode(body));

    return response;
  }

  /// Método para eliminar un personaje.
  ///
  /// Recibe un [id] para ingresar en la API.
  ///
  /// Retorna la respuesta que arroje el servidor
  static Future<http.Response> eliminarPersonaje(String id, context) async {
    var url = Uri.parse(_urlEndpoint + id);
    var response = await http.delete(url);

    return response;
  }
}
