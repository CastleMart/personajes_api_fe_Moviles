//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Buscador.dart';
import 'package:personajes_api_fe/Herramientas/EnlistarPersonajes.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/disenios.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/ActualizarPersonaje.dart';
import 'package:personajes_api_fe/views/CrearPersonaje.dart';
import 'package:personajes_api_fe/views/VerPersonaje.dart';

import 'Herramientas/Botones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//-----------------------------------------------------------------------------------------------------------------------------
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  PersonajeController connect = new PersonajeController();
  Future<List<Personaje>> personajes = PersonajeController.getPersonajes();
  late List<Personaje> personajesFiltrados;
  late List<Personaje> personajesLista;
  int idMayor = 0;

  @override
  void initState() {
    // TODO: implement initState
    personajes = PersonajeController.getPersonajes();
    super.initState();
  }

  void _reloadItems() {
    setState(() {
      personajes = PersonajeController.getPersonajes();
    });
  }

  @override
  Widget build(BuildContext context) {
    _reloadItems();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mi aplicación',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Personajes Fire Emblem"),
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () {
                      //showSearch(context: context, delegate: Buscador());
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child:
                      EnlistarPersonajes.regresarFuturePersonajes(personajes),
                ),
                FutureBuilder(
                    builder: (context, sanp) => Botones.botonCrearPersonaje(
                        context, EnlistarPersonajes.idMayor)),
                _botonActualizarPagina(),
              ],
            )));
  }

  /**
   * Método que actualiza la página principal.
   */
  Widget _botonActualizarPagina() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            _reloadItems();
          },
          child: Text("Actualizar página")),
    );
  }
}
