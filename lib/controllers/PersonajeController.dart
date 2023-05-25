import 'package:personajes_api_fe/models/personaje.dart';
import "package:http/http.dart" as http;

class PersonajeController {
  //Future<List<Personaje>> _listaPersonajes;

  Future<List<Personaje>> getPersonajes() async {
    var url = Uri.parse(
        'https://rc4w8ry6ye.execute-api.us-east-1.amazonaws.com/test');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      throw Exception("Falló la conexión.");
    }
    //_listaPersonajes = [Personaje("id", "nombre", "fuerza", "defenza")]
    //  as Future<List<Personaje>>;
    return [Personaje("id", "nombre", "fuerza", "defenza")]; //_listaPersonajes;
  }
}
