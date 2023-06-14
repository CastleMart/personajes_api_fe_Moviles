import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import '../disenios.dart';
import '../models/personaje.dart';
import '../views/VerPersonaje.dart';

class EnlistarPersonajes {
  static int idMayor = 0;
  static List<Personaje> personajes = [];

  EnlistarPersonajes(Future<List<Personaje>> personajes);

  /**
   * Widget que regresa las tarjetas de los personajes acomodados.
   * 
   */
  static Widget regresarFuturePersonajes(Future<List<Personaje>> personajes) {
    return FutureBuilder(
      future: personajes,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 2,
            children: _listaPersonajes(snapshot.requireData, context),
          );
        } else if (snapshot.hasError) {
          return Text("Error");
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static List<Widget> _listaPersonajes(List<Personaje> datos, context) {
    List<Widget> personajesWid = [];
    List<int> id = [];

    for (var item in datos) {
      id.add(int.parse(item.id));
      personajesWid.add(Card(
          key: UniqueKey(),
          child: Column(
            children: [
              Text.rich(TextSpan(
                  text: item.nombre,
                  style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                child: Image.network(
                  item.img,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Error handling code goes here

                    return Text('Imagen no encontrada');
                  },
                ),
              ),
              //Disenios.atributosPersonaje("Fuerza", item.fuerza, 2.0),
              Disenios.atributosPersonaje("Defensa", item.defenza, 2.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerPersonaje(item)));
                  },
                  child: Text("Ver Detalles")),
            ],
          )));
    }

    idMayor = id.reduce((value, element) => value > element ? value : element);
    print(idMayor);
    return personajesWid;
  }

  static int obtenerIdMayor() {
    return idMayor;
  }
}
