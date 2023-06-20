import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/views/Opciones.dart';
import 'package:personajes_api_fe/views/navBar.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';
import '../providers/personajes_provider.dart';
import 'CrearPersonaje.dart';
import 'Favoritos_Page.dart';
import 'Home.dart';
import 'login.dart';

///Clase que muestra la pantalla principal con sus respecticvas subpáginas.
class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  // This widget is the root of your application.
  PersonajeController connect = PersonajeController();
  late Future<List<Personaje>> personajes;
  late List<Personaje> personajesFiltrados;
  late List<Personaje> personajesLista;
  int _paginaActual = 0;
  int idMayor = 0;

  //*Lista de páginas del navegador según el rol del usuario.
  List<Widget> _paginasAdmin = [Home(), CrearPersonaje(), Opciones()];

  List<Widget> _paginasUsuario = [Home(), FavoritosPage(), Opciones()];

  //* Íconos a mostrar en el navegador según el tipo de rol del usuario
  List<BottomNavigationBarItem> _navAdmin = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.add_box), label: "Ingresar Personaje"),
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Opciones")
  ];

  List<BottomNavigationBarItem> _navUsuario = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritos"),
    BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Opciones")
  ];

  late List<BottomNavigationBarItem> _tipoNav;
  late List<Widget> _paginas;

  @override
  Widget build(BuildContext context) {
    //*Verificación del tipo de usuario
    if (context.watch<PersonajesProvider>().esAdmin) {
      _tipoNav = _navAdmin;
      _paginas = _paginasAdmin;
    } else {
      _tipoNav = _navUsuario;
      _paginas = _paginasUsuario;
    }
    //*Construcción de la vista principal de la app.
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
