//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:personajes_api_fe/Herramientas/Buscador.dart';
import 'package:personajes_api_fe/Herramientas/EnlistarPersonajes.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/providers/personajes_provider.dart';
import 'package:personajes_api_fe/views/ActualizarPersonaje.dart';
import 'package:personajes_api_fe/views/CrearPersonaje.dart';
import 'package:personajes_api_fe/views/Favoritos_Page.dart';
import 'package:personajes_api_fe/views/Home.dart';
import 'package:personajes_api_fe/views/VerPersonaje.dart';
import 'package:provider/provider.dart';

import 'Herramientas/Botones.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => PersonajesProvider(),
    child: const MyApp(),
  ));
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
  int _paginaActual = 0;
  int idMayor = 0;

  List<Widget> _paginasAdmin = [Home(), CrearPersonaje()];
  List<Widget> _paginasUsuario = [Home(), FavoritosPage()];
  List<BottomNavigationBarItem> _navAdmin = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.create), label: "Ingresar Personaje")
  ];
  List<BottomNavigationBarItem> _navUsuario = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritos"),
  ];

  late List<BottomNavigationBarItem> _tipoNav;
  late List<Widget> _paginas;

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
    if (context.watch<PersonajesProvider>().esAdmin) {
      _tipoNav = _navAdmin;
      _paginas = _paginasAdmin;
    } else {
      _tipoNav = _navUsuario;
      _paginas = _paginasUsuario;
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _paginas[_paginaActual],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _paginaActual = index;
              });
            },
            currentIndex: _paginaActual,
            items: _tipoNav),
      ),
    );
  }
}
