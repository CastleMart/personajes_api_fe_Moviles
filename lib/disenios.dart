import 'dart:ffi';

import 'package:flutter/cupertino.dart';

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
}
