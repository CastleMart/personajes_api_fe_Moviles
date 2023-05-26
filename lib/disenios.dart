import 'package:flutter/cupertino.dart';

class Disenios {
  static Widget atributosPersonaje(String campo, String valor) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
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
