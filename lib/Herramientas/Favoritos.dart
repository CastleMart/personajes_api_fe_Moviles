import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/main.dart';

class Favorito {
  static favorito(String id, bool valor, context) {
    return IconButton(
        onPressed: () {
          PersonajeController.actualizarPersonajeFavorito(id, !valor);
          //favorito(id, !valor);
        },
        icon: icono(valor));
  }

  static icono(bool value) {
    if (value) {
      return Icon(
        Icons.star,
        color: Colors.purple,
      );
    } else {
      return Icon(
        Icons.star_border,
        color: Colors.purple,
      );
    }
  }
}
