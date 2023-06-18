import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Favoritos.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';

class PersonajesProvider with ChangeNotifier {
  PersonajeController connect = new PersonajeController();
  late Future<List<Personaje>> _personajes = connect.getPersonajes();
  bool _esAdmin = false;

  Future<List<Personaje>> get personajes => _personajes;
  bool get esAdmin => _esAdmin;

  void cambiarTipoUsuario() {
    _esAdmin = !_esAdmin;
    notifyListeners();
  }

  void setTipoUsuario(bool tipoUsuario) {
    _esAdmin = tipoUsuario;
    notifyListeners();
  }

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
