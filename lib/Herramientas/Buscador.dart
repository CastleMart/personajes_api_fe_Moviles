import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/EnlistarPersonajes.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/VerPersonaje.dart';
import 'package:personajes_api_fe/views/VerPersonajeUser.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../providers/personajes_provider.dart';

class Buscador extends SearchDelegate {
  late final List<Personaje> listaDeBusqueda;
  PersonajeController conn = PersonajeController();
  //lista = conn.getPersonajes();

  Buscador() {}

  //Método que devuelve la lista de personajes
  static Future<List<Personaje>> _listaPersonajes() {
    PersonajeController con = PersonajeController();

    return con.getPersonajes();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Personaje>>(
        future: _listaPersonajes(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
          if (snapshot.hasData) {
            final resultados = query.isEmpty
                ? []
                : snapshot.requireData
                    .where((element) => element.nombre
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();

            return ListView.builder(
              itemCount: resultados.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(resultados[index].nombre),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text("Vacío"),
      );
    }
    return FutureBuilder<List<Personaje>>(
      future: _listaPersonajes(),
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
        if (snapshot.hasData) {
          final sugerencias = query.isEmpty
              ? []
              : snapshot.requireData
                  .where((element) => element.nombre
                      .toLowerCase()
                      .contains(query.trim().toLowerCase()))
                  .toList();
          if (context.watch<PersonajesProvider>().esAdmin) {
            return ListView.builder(
              itemCount: sugerencias.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(sugerencias[index].nombre),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VerPersonaje(sugerencias[index])))),
            );
          } else {
            return ListView.builder(
              itemCount: sugerencias.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(sugerencias[index].nombre),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              VerPersonajeUser(sugerencias[index])))),
            );
          }
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
