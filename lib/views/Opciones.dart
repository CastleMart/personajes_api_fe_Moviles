import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/UsuariosController.dart';
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
              margin: EdgeInsets.fromLTRB(25, 40, 25, 40),
              color: Color.fromARGB(255, 212, 217, 246),
              shadowColor: Colors.green,
              //shadowColor: Color.fromARGB(255, 65, 188, 67),
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.purple.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  CircleAvatar(
                    radius: 100.0,
                    backgroundImage: NetworkImage(
                        "https://i.pinimg.com/474x/12/56/de/1256def18416a032b0a118a0965714bd--identity-design-design-logos.jpg"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Title(
                        color: Colors.black,
                        child: Text(
                          "Nombre de usuario",
                          style: TextStyle(fontFamily: 'Arial', fontSize: 20.0),
                        )),
                  ),
                  Text(nombreUsuario),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Title(
                        color: Colors.black,
                        child: Text(
                          "Nombre completo",
                          style: TextStyle(fontFamily: 'Arial', fontSize: 20.0),
                        )),
                  ),
                  Text(nombreCompleto)
                ]),
              ),
            ),
            tarjetas(Icon(Icons.logout), () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }),
            Visibility(
                visible: UsuariosController.getEsAdmin(),
                child: tarjetas(Icon(Icons.change_circle), () {
                  context.read<PersonajesProvider>().cambiarTipoUsuario();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PantallaPrincipal()));
                })),
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
