import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/EnlistarPersonajes.dart';
import 'package:personajes_api_fe/models/personaje.dart';

import '../controllers/PersonajeController.dart';

class Buscador extends SearchDelegate {
  late final List<Personaje> listaDeBusqueda;
  final lista = PersonajeController.getPersonajes();

  Buscador() {}

  static listaPersonajes() async {
    List<Personaje> listaPersonajes = await PersonajeController.getPersonajes();
    return listaPersonajes;
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
    final resultados = listaDeBusqueda
        .where((element) => element.nombre.contains(query))
        .toList();

    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(resultados[index].nombre),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final sugerencias = query.isEmpty
        ? []
        : listaDeBusqueda
            .where((element) => element.nombre.contains(query))
            .toList();
    return ListView.builder(
      itemCount: sugerencias.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(sugerencias[index]),
        onTap: () {
          query = sugerencias[index];
          showResults(context);
        },
      ),
    );
  }
}
