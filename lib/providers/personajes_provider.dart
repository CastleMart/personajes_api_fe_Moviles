import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Favoritos.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';

class PersonajesProvider with ChangeNotifier {
  PersonajeController connect = new PersonajeController();
  late Future<List<Personaje>> _personajes = connect.getPersonajes();
  Usuario _usuario = Usuario("", "");
  bool _esAdmin = false;

  Future<List<Personaje>> get personajes => _personajes;
  bool get esAdmin => _esAdmin;
  Usuario get usuario => _usuario;

  void setUsuarios(Usuario usuario) {
    _usuario = usuario;
  }

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
