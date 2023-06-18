import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import 'package:personajes_api_fe/views/Home.dart';
import 'package:personajes_api_fe/views/PantallaPrincipal.dart';
import 'package:personajes_api_fe/views/login.dart';
import 'package:provider/provider.dart';

import '../providers/personajes_provider.dart';

class Opciones extends StatelessWidget {
  const Opciones({super.key});

  @override
  Widget build(BuildContext context) {
    bool esAdmin;
    String nombreUsuario =
        context.watch<PersonajesProvider>().usuario.nombreUsuario;
    String nombreCompleto = context.watch<PersonajesProvider>().usuario.nombre;
    return Scaffold(
        appBar: AppBar(title: const Text('Opciones')),
        body: Center(
            child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.grey,
                  ),
                  Title(
                      color: Colors.black,
                      child: Text(
                        "Nombre de usuario",
                        style: TextStyle(fontFamily: 'Arial', fontSize: 20.0),
                      )),
                  Text(nombreUsuario),
                  Title(
                      color: Colors.black,
                      child: Text(
                        "Nombre completo",
                        style: TextStyle(fontFamily: 'Arial', fontSize: 20.0),
                      )),
                  Text(nombreCompleto)
                ]),
              ),
            ),
            tarjetas(Icon(Icons.logout), () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }),
            tarjetas(Icon(Icons.change_circle), () {
              context.read<PersonajesProvider>().cambiarTipoUsuario();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PantallaPrincipal()));
            }),
          ],
        )));
  }

  tarjetas(Icon icono, pantalla) {
    return Container(
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ))),
              child: icono,
              onPressed: pantalla),
        ));
  }
}
