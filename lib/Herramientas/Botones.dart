import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/disenios.dart';
import 'package:personajes_api_fe/main.dart';
import '../views/CrearPersonaje.dart';

class Botones {
  static Widget botonCrearPersonaje(context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CrearPersonaje()));
          },
          child: Text("Ingresar Personaje")),
    );
  }

  static Widget botonEliminarPersonaje(context, id) {
    return ElevatedButton(
        onPressed: () {
          Disenios.alertaBorrar(context, id);
          //MaterialPageRoute(builder: (context) => new MyApp());
          Navigator.pop(context);
        },
        child: Text("Borrar"));
  }
}
