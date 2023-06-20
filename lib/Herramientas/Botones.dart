import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import 'package:personajes_api_fe/main.dart';
import 'package:personajes_api_fe/views/Home.dart';
import 'package:personajes_api_fe/views/PantallaPrincipal.dart';
import '../views/CrearPersonaje.dart';
import 'disenios.dart';

class Botones {
  ///Botón [Widget] que se encarga de eliminar un personaje por medio de su [id].
  static Widget botonEliminarPersonaje(context, id) {
    return IconButton(
      onPressed: () async {
        await Disenios.alertaBorrar(context, id);

        //MaterialPageRoute(builder: (context) => new MyApp());
        //Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      },
      icon: Icon(
        Icons.delete,
        color: Colors.deepPurple,
      ),
    );
  }
}
