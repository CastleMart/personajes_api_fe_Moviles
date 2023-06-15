import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Herramientas/Botones.dart';
import '../Herramientas/EnlistarPersonajes.dart';
import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';
import '../providers/personajes_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersonajeController connect = new PersonajeController();
  late Future<List<Personaje>> personajes;

  @override
  void initState() {
    // TODO: implement initState
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
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
          //print(context.watch<PersonajesProvider>().personajes);
        });
  }
}
