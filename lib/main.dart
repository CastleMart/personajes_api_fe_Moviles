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
  late Future<List<Personaje>> personajes;
  late List<Personaje> personajesFiltrados;
  late List<Personaje> personajesLista;
  int idMayor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ObtenerPersonajes();
  }

  Future<void> ObtenerPersonajes() async {
    try {
      personajes = connect.getPersonajes();
    } catch (e) {
      print(e);
    }

    setState(() {
      personajes = personajes;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            body: RefreshIndicator(
                backgroundColor: Colors.purple,
                color: Colors.white,
                displacement: 20.0,
                strokeWidth: 4,
                child: Column(
                  children: [
                    Expanded(
                      child: EnlistarPersonajes.regresarFuturePersonajes(
                          personajes),
                    ),
                    FutureBuilder(
                        builder: (context, sanp) => Botones.botonCrearPersonaje(
                            context, EnlistarPersonajes.idMayor))
                  ],
                ),
                onRefresh: ObtenerPersonajes)));
  }
}
