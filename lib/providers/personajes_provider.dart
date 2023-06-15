import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Favoritos.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';

class PersonajesProvider with ChangeNotifier {
  PersonajeController connect = new PersonajeController();
  late Future<List<Personaje>> _personajes = connect.getPersonajes();
  //bool _favorito = false;

  Future<List<Personaje>> get personajes => _personajes;
  //bool get favorito => _favorito;
  //void set favorito(valor) => _favorito = valor;

  /*
  void switchFavorito() {
    _favorito = !_favorito;
  }*/

  void obtenerPersonaje() {
    _personajes = connect.getPersonajes();
    notifyListeners();
  }

  Future<void> ObtenerPersonajes() async {
    try {
      _personajes = connect.getPersonajes();
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
