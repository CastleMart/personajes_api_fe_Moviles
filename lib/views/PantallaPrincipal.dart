import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';
import '../providers/personajes_provider.dart';
import 'CrearPersonaje.dart';
import 'Favoritos_Page.dart';
import 'Home.dart';
import 'login.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
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
        resizeToAvoidBottomInset: false,
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
