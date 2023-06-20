import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/controllers/UsuariosController.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/providers/personajes_provider.dart';
import 'package:provider/provider.dart';

import '../Herramientas/CartasPersonajes.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  late List<Personaje> listaPersonajes = [];
  late List<Personaje> listaFavoritos = [];
  late Usuario usuario;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    usuario = context.read<PersonajesProvider>().usuario;
    () async {
      await obtenerPersonajesList(usuario);
    }();
  }

  Future<void> obtenerPersonajesList(Usuario usuario) async {
    PersonajeController connect = PersonajeController();
    try {
      var personajes = connect.getPersonajes();
      listaPersonajes = await personajes;
      obtenerPersonajesFavoritos(usuario);
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Usuario usuario = context.read<PersonajesProvider>().usuario;
    List<Personaje> personajes = [];
    obtenerPersonajesFavoritos(usuario);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              backgroundColor: Colors.purple,
              color: Colors.white,
              displacement: 20.0,
              strokeWidth: 4,
              child: CartasPersonajes.cardListViewFavoritos(listaFavoritos),
              onRefresh: () async {
                setState(() {
                  _isLoading = true;
                });
                await obtenerPersonajesList(usuario);
                setState(() {
                  _isLoading = false;
                });

                //obtenerPersonajesFavoritos(usuario);
              },
            ),
    );
  }

  List<Personaje> obtenerPersonajesFavoritos(Usuario usuario) {
    listaFavoritos.clear();
    for (var personaje in listaPersonajes) {
      var existe = usuario.favoritos.map((e) => e == personaje.id);

      if (existe.contains(true)) {
        listaFavoritos.add(personaje);
      }
    }
    return [];
  }
}
