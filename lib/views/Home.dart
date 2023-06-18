import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Herramientas/Botones.dart';
import '../Herramientas/Buscador.dart';
import '../Herramientas/CartasPersonajes.dart';
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
  late List<Personaje> personajesList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    obtenerPersonajes();
  }

  Future<void> obtenerPersonajes() async {
    try {
      personajes = connect.getPersonajes();
      personajesList = await personajes;
    } catch (e) {
      print(e);
    }

    setState(() {
      personajes = personajes;
      personajesList = personajesList;
      //_isLoading = false;
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
            child: CartasPersonajes.cardListView(
                personajesList, context.read<PersonajesProvider>().esAdmin),
            onRefresh: () async {
              context.read<PersonajesProvider>().obtenerPersonaje();
              obtenerPersonajes();
            },
          ),
        ),
      ),
    )
        //child: Center(
        //    child: CircularProgressIndicator(backgroundColor: Colors.white))
        ;
  }
}
