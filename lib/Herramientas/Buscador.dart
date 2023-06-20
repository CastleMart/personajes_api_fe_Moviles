import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/CartasPersonajes.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/VerPersonaje.dart';
import 'package:personajes_api_fe/views/VerPersonajeUser.dart';
import 'package:provider/provider.dart';

import '../controllers/PersonajeController.dart';
import '../providers/personajes_provider.dart';

///Clase que realiza los filtros necesarios para la realización de la búsqueda.
class Buscador extends SearchDelegate {
  List<Personaje> listaDeBusqueda = [];
  PersonajeController conn = PersonajeController();

  Buscador() {}

  ///Obtención de una [List] de [Personaje] por medio de la clase [PersonajeController].
  static Future<List<Personaje>> _listaPersonajes() {
    PersonajeController con = PersonajeController();
    return con.getPersonajes();
  }

  ///Método de [Buscador] que elimina el contenido de
  ///la barra de búsqueda.
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  ///Método que programa la función de terminar la búsqueda.
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Personaje>>(
      future: _listaPersonajes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          listaDeBusqueda = snapshot.data!;
          if (query.isEmpty) {
            return Center(
              child: Text("Sin contenido"),
            );
          }

          // * Enlistado de los perosnajes que coincidan con la búqueda.
          List<Personaje> sugerencias = listaDeBusqueda.where((personaje) {
            return personaje.nombre.toLowerCase().contains(query.toLowerCase());
          }).toList();

          if (sugerencias.isEmpty) {
            return Center(
              child: Text("No se encontraron resultados"),
            );
          }

          return ListView.builder(
              itemCount: sugerencias.length,
              itemBuilder: (context, index) {
                return _buildTarjeta(sugerencias[index], context,
                    context.watch<PersonajesProvider>().esAdmin);
              });
        }
      },
    );
  }

  ///Método que construye la vista del buscador.
  Widget _buildTarjeta(
      Personaje personaje, BuildContext context, bool tipoUsuario) {
    return Card(
      color: Color.fromARGB(255, 182, 192, 253),
      shadowColor: Color.fromARGB(255, 65, 188, 67),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.purple.shade300),
      ),
      child: ListTile(
        title: Text(personaje.nombre),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fuerza: ${personaje.fuerza}'),
            Text('Defensa: ${personaje.defensa}'),
          ],
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(personaje.imgPixel),
        ),
        onTap: () {
          showResults(context);

          if (tipoUsuario) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerPersonaje(personaje),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VerPersonajeUser(personaje),
              ),
            );
          }
        },
      ),
    );
  }
}
