import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Herramientas/Botones.dart';
import '../Herramientas/Buscador.dart';
import '../Herramientas/EnlistarPersonajes.dart';
import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';
import '../providers/personajes_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersonajeController connect = PersonajeController();
  late Future<List<Personaje>> personajes;

  @override
  void initState() {
    super.initState();
    obtenerPersonajes();
  }

  Future<void> obtenerPersonajes() async {
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
      home: SafeArea(
        child: Scaffold(
          //resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text("Personajes Fire Emblem"),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    showSearch(context: context, delegate: Buscador());
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
                  child: EnlistarPersonajes.regresarFuturePersonajes(context),
                ),
              ],
            ),
            onRefresh: () async {
              context.read<PersonajesProvider>().obtenerPersonaje();
            },
          ),
        ),
      ),
    );
  }
}
