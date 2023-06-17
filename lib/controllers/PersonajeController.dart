import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/main.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import "package:http/http.dart" as http;

class PersonajeController {
  //Future<List<Personaje>> _listaPersonajes;
  //static List<Personaje> personajes = [];

  ///Método que regresa todos los personajes disponibles en la API.
  ///
  ///Devuelve como resultado [personajes]
  Future<List<Personaje>> getPersonajes() async {
    List<Personaje> personajes = [];
    var url = Uri.parse(
        'https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //var body = utf8.decode(response.body);
      personajes = [];
      final jsonData = jsonDecode(response.body);

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

  static Future<Personaje> getPersonajeId(String id) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test/" + id);
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
      print(jsonData["Nombre"]);
      return personaje;
    } else {
      return throw Exception("Falló la conexión.");
    }
  }

  crearPersonaje(Personaje personaje, context) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test");
    var body = {
      "idPersonaje": personaje.id,
      "Defenza": personaje.defenza,
      "Nombre": personaje.nombre,
      "Fuerza": personaje.fuerza,
      "Img": personaje.img,
      "ImgPixel": personaje.imgPixel
    };
    var response = await http.post(url, body: jsonEncode(body));
    print('Id: ${personaje.id}');
    print('Respuesta cuerpo: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Disenios.verBarraAccion("Se ha ingresado el personaje", context);
    }

    //Navigator.pop(context);
  }

  actualizarPersonaje(Personaje personaje, context) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test");
    var body = {
      "idPersonaje": personaje.id,
      "Defenza": personaje.defenza,
      "Nombre": personaje.nombre,
      "Fuerza": personaje.fuerza,
      "Img": personaje.img,
      "ImgPixel": personaje.imgPixel
    };
    var response = await http.put(url, body: jsonEncode(body));
    print('Id: ${personaje.id}');
    print('Respuesta cuerpo: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Disenios.verBarraAccion("Se ha actualizado", context);
    }
  }

  static actualizarPersonajeFavorito(String id, bool favorito) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test");
    var body = {"idPersonaje": id, "Favorito": favorito};
    var response = await http.put(url, body: jsonEncode(body));
    //print('Id: ${personaje.id}');
    //print('Respuesta cuerpo: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      //Disenios.verBarraAccion("Se ha actualizado", context);
    }
  }

  static Future<http.Response> eliminarPersonaje(String id, context) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test/" + id);
    var response = await http.delete(url);

    return response;
  }
}
