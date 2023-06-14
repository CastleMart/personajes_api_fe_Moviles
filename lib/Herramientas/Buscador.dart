import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/EnlistarPersonajes.dart';
import 'package:personajes_api_fe/models/personaje.dart';

import '../controllers/PersonajeController.dart';

class Buscador extends SearchDelegate {
  late final List<Personaje> listaDeBusqueda;
  PersonajeController conn = PersonajeController();
  //lista = conn.getPersonajes();

  Buscador() {}

  static Future<List<Personaje>> listaPersonajes() {
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
      future: listaPersonajes(),
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
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
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Personaje>>(
      future: listaPersonajes(),
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
        if (snapshot.hasData) {
          final sugerencias = query.isEmpty
              ? []
              : snapshot.requireData
                  .where((element) => element.nombre
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();

          return ListView.builder(
            itemCount: sugerencias.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(sugerencias[index].nombre),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
