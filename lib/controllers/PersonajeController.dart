import 'dart:convert';

import 'package:personajes_api_fe/disenios.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import "package:http/http.dart" as http;

class PersonajeController {
  //Future<List<Personaje>> _listaPersonajes;
  List<Personaje> personajes = [];

  Future<List<Personaje>> getPersonajes() async {
    var url = Uri.parse(
        'https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      //var body = utf8.decode(response.body);

      final jsonData = jsonDecode(response.body);

      for (var item in jsonData) {
        personajes.add(Personaje(item["idPersonaje"], item["Nombre"],
            item["Fuerza"], item["Defenza"], item["Img"]));
      }
    } else {
      throw Exception("Falló la conexión.");
    }

    return personajes;
  }

  crearPersonaje(Personaje personaje) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test");
    var body = {
      "idPersonaje": personaje.id,
      "Defenza": personaje.defenza,
      "Nombre": personaje.nombre,
      "Fuerza": personaje.fuerza,
      "Img": personaje.img
    };
    var response = await http.post(url, body: jsonEncode(body));
    print('Id: ${personaje.id}');
    print('Respuesta cuerpo: ${response.statusCode}');
  }

  actualizarPersonaje(Personaje personaje, context) async {
    var url = Uri.parse(
        "https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test");
    var body = {
      "idPersonaje": personaje.id,
      "Defenza": personaje.defenza,
      "Nombre": personaje.nombre,
      "Fuerza": personaje.fuerza,
      "Img": personaje.img
    };
    var response = await http.put(url, body: jsonEncode(body));
    print('Id: ${personaje.id}');
    print('Respuesta cuerpo: ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      Disenios.verBarraAccion("Se ha actualizado", context);
    }
  }
}