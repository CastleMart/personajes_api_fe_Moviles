import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/CancelActionButton.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import 'ConfirmActionButton.dart';
//import 'Herramientas/ConfirmActionButton.dart';

class Disenios {
  static Widget atributosPersonaje(String campo, String valor, double pad) {
    return Padding(
      padding: EdgeInsets.all(pad),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              campo,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(valor),
          ]),
    );
  }

  static Widget fieldTextDatoPersonaje(controlTexto, String campo) {
    return Container(
      padding: EdgeInsets.all(15),
      child: TextField(
        controller: controlTexto,
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.grey[300],
            filled: true,
            hintText: campo),
      ),
    );
  }

  ///Barra que realiza una acción según el mensaje que recibe
  ///recibe [mensaje] y [context]
  static void verBarraAccion(String mensaje, context) {
    final barraBaja = SnackBar(
        content: Text(
      mensaje,
      textAlign: TextAlign.center,
    ));
    ScaffoldMessenger.of(context).showSnackBar(barraBaja);
  }

  static alertaBorrar(context, id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("¿Desea borrar al Personaje?"),
              backgroundColor: Color.fromARGB(255, 209, 216, 255),
              actions: [
                const CancelActionButton(), //ConfirmActionButton(),
                ConfirmActionButton(
                    onPressed: () async => {
                          await PersonajeController.eliminarPersonaje(
                              id, context),
                          //Navigator.pop(context)
                        }),
              ],
            ));
  }

  static alertaError(context, id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("Complete todos los campos"),
              actions: [
                const CancelActionButton(), //ConfirmActionButton(),
                ConfirmActionButton(onPressed: () => {}),
              ],
            ));
  }
}
