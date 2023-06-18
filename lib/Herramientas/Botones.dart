import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import 'package:personajes_api_fe/main.dart';
import 'package:personajes_api_fe/views/Home.dart';
import 'package:personajes_api_fe/views/PantallaPrincipal.dart';
import '../views/CrearPersonaje.dart';
import 'disenios.dart';

class Botones {
  static Widget botonCrearPersonaje(context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => CrearPersonaje()));
          },
          child: Text("Ingresar Personaje")),
    );
  }

  static Widget botonEliminarPersonaje(context, id) {
    return ElevatedButton(
        onPressed: () async {
          await Disenios.alertaBorrar(context, id);

          //MaterialPageRoute(builder: (context) => new MyApp());
          //Navigator.pop(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Text("Borrar"));
  }
}
