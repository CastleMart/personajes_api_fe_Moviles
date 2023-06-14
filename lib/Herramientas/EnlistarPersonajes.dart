import 'dart:core';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Favoritos.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import '../disenios.dart';
import '../models/personaje.dart';
import '../views/ActualizarPersonaje.dart';
import '../views/VerPersonaje.dart';
import 'Botones.dart';

class EnlistarPersonajes {
  static int idMayor = 0;
  static List<Personaje> personajesList = [];

  EnlistarPersonajes(Future<List<Personaje>> personajes);

  /**
   * Widget que regresa las tarjetas de los personajes acomodados.
   * 
   */
  static Widget regresarFuturePersonajes(Future<List<Personaje>> personajes) {
    return FutureBuilder<List<Personaje>>(
      future: personajes,
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 1,
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

  /**
   * Widget que regresa una tarjeta de personaje.
   * 
   */
  static Widget regresarUnPersonaje(Future<Personaje> personajeFuture) {
    Personaje personaje;
    return FutureBuilder<Personaje>(
      future: personajeFuture,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          personaje = snapshot.requireData;
          return Center(
              child: Card(
                  elevation: 5,
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //textos.value(TextEditingValue(text: item.nombre)),
                      Expanded(
                        child: Image.network(
                          personaje.img,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            // Error handling code goes here
                            return Text('Imagen no encontrada');
                          },
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Disenios.atributosPersonaje(
                              "Nombre", personaje.nombre, 8.0),
                          Disenios.atributosPersonaje(
                              "Fuerza", personaje.fuerza, 8.0),
                          Disenios.atributosPersonaje(
                              "Defensa", personaje.defenza, 8.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActualizarPersonaje(
                                                    personaje)));
                                  },
                                  child: Text("Editar")),
                              Botones.botonEliminarPersonaje(
                                  context, personaje.id),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )));
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
          elevation: 8,
          color: Color.fromARGB(255, 231, 228, 234),
          //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          key: UniqueKey(),
          child: Container(
              //padding: EdgeInsets.all(5),
              child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(8),
                  child: Text.rich(TextSpan(
                      text: item.nombre,
                      style: TextStyle(fontWeight: FontWeight.bold)))),
              /*
              FadeInImage(
                
                  placeholder: NetworkImage(
                      "https://th.bing.com/th/id/R.22b7e7a5aef22403aaf97755af213977?rik=f23kFTiJ3WRemA&pid=ImgRaw&r=0"),
                  image: NetworkImage(item.img)),
              */

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

              Favorito.favorito(item.id, item.favorito, context),
              //Disenios.atributosPersonaje("Fuerza", item.fuerza, 2.0),
              //Disenios.atributosPersonaje("Defensa", item.defenza, 2.0)
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VerPersonaje(item)));
                  },
                  child: Text("Ver Detalles")),
            ],
          ))));
    }

    idMayor = id.reduce((value, element) => value > element ? value : element);
    print(idMayor);
    return personajesWid;
  }

  static int obtenerIdMayor() {
    return idMayor;
  }
}
