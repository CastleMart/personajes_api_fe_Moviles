import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Disenios {
  static Widget atributosPersonaje(String campo, String valor, double pad) {
    return Padding(
      padding: EdgeInsets.all(pad),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Text(campo),
            ),
            Container(
              child: Text(valor),
            ),
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
}
