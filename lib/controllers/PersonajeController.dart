import 'dart:convert';

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
}
