import 'dart:core';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Favoritos.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import 'package:personajes_api_fe/views/VerPersonajeUser.dart';
import 'package:provider/provider.dart';

import '../models/personaje.dart';
import '../providers/personajes_provider.dart';
import '../views/ActualizarPersonaje.dart';
import '../views/VerPersonaje.dart';
import 'Botones.dart';
import 'disenios.dart';

class CartasPersonajes {
  static int idMayor = 0;
  static List<Personaje> personajesList = [];
/*
  CartasPersonajes(Future<List<Personaje>> personajes);

  /// Widget que regresa las tarjetas de los personajes acomodados.
  ///
  /// Este widget regresa una [FutureBuilder] que muestra una lista de tarjetas de personajes.
  ///
  /// El [BuildContext] es necesario para obtener la instancia de [PersonajesProvider].
  static Widget regresarFuturePersonajes(BuildContext context) {
    return FutureBuilder<List<Personaje>>(
      future: context.watch<PersonajesProvider>().personajes,
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
        if (snapshot.hasData) {
          return GridView.count(
            crossAxisCount: 1,
            children: listaPersonajes(snapshot.requireData, context),
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

  /// Crea una lista de widgets de personajes.
  ///
  /// Esta función toma una lista de [Personaje] y un [BuildContext] y devuelve una lista de [Widget].
  ///
  /// La lista de widgets se crea a partir de la lista de personajes proporcionada. También se guarda el id más grande en la variable global [idMayor].
  static List<Widget> listaPersonajes(
      List<Personaje> datos, BuildContext context) {
    List<Widget> personajesWid = [];
    List<int> id = [];

    for (var item in datos) {
      id.add(int.parse(item.id));
      personajesWid.add(cardPersonaje(item, context));
    }

    idMayor = id.reduce((value, element) => value > element ? value : element);
    print(idMayor);
    return personajesWid;
  }

  /// Crea una tarjeta para mostar el personaje.
  ///
  /// Esta función toma un [Personaje] y un [BuildContext] y devuelve un [Card].
  ///
  /// La tarjeta de personaje contiene el nombre del personaje, una imagen.
  static Widget cardPersonaje(Personaje personaje, BuildContext context) {
    return Card(
        elevation: 8,
        color: Colors.white70,
        shadowColor: Colors.purple,
        //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        key: UniqueKey(),
        child: Container(
            //padding: EdgeInsets.all(5),
            child: Column(children: [
          Padding(
              padding: EdgeInsets.all(8),
              child: Text.rich(TextSpan(
                  text: personaje.nombre,
                  style: TextStyle(fontWeight: FontWeight.bold)))),
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
          _seleccionarTipoCardOpcion(personaje, context)
        ])));
  }

  ///Verifica qué tipo de usuario es el que ingresó a la aplicación y muestra
  ///opciones según sea el caso.
  ///
  ///Esta función que recibe un [Personaje] y un [BuildContext].
  ///
  ///Esta función retorna un [Card].
  static _seleccionarTipoCardOpcion(Personaje personaje, BuildContext context) {
    if (context.watch<PersonajesProvider>().esAdmin) {
      return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerPersonaje(personaje)));
            },
            child: Text("Ver Detalles")),
      );
    } else {
      return Column(children: [
        IconButton(
            onPressed: () {
              PersonajeController.actualizarPersonajeFavorito(
                  personaje.id, !personaje.favorito);
              context.read<PersonajesProvider>().obtenerPersonaje();
            },
            icon: Icon(
              Icons.star,
              color: Colors.purple,
            )),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VerPersonajeUser(personaje)));
            },
            child: Text("Ver Detalles"))
      ]);
    }
  }

  static int obtenerIdMayor() {
    return idMayor;
  }*/

//--------------------------------------------------

  ///Verifica qué tipo de usuario es el que ingresó a la aplicación y muestra
  ///opciones según sea el caso.
  ///
  ///Esta función que recibe un [Personaje] y un [BuildContext].
  ///
  ///Esta función retorna un [Widget].
  static _seleccionarCardUsuario(
      Personaje personaje, Usuario usuario, BuildContext context) {
    //bool admin = true; //;
    if (context.watch<PersonajesProvider>().esAdmin) {
      //! Aquí mando a llamar a mi página actualizar personaje.
      return IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ActualizarPersonaje(personaje)));
          },
          icon: Icon(
            Icons.edit,
            color: Colors.purple,
          ));
    } else {
      if (usuario.favoritos.contains(personaje.id)) {
        return IconButton(
            onPressed: () {
              PersonajeController.actualizarPersonajeFavorito(
                  personaje.id, !personaje.favorito);
              context.read<PersonajesProvider>().obtenerPersonaje();
            },
            icon: Icon(
              Icons.star,
            ));
      } else {
        return IconButton(
            onPressed: () {
              PersonajeController.actualizarPersonajeFavorito(
                  personaje.id, !personaje.favorito);
              context.read<PersonajesProvider>().obtenerPersonaje();
            },
            icon: Icon(Icons.star_border));
      }
    }
  }

  static Widget cardListView(List<Personaje> personajes, bool tipoUsuario,
      controller, bool isLoading) {
    List<int> id = [];
    return ListView.builder(
      itemCount: personajes.length + 1,
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        if (index < personajes.length) {
          final personaje = personajes[index];

          for (var item in personajes) {
            id.add(int.parse(item.id));
          }

          idMayor =
              id.reduce((value, element) => value > element ? value : element);
          print(idMayor);
          return Card(
              //shape: ,
              child: Container(
            alignment: AlignmentDirectional.center,
            height: 100,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(personajes[index].imgPixel)),
              trailing: _seleccionarCardUsuario(personajes[index],
                  context.read<PersonajesProvider>().usuario, context),
              title: Text(personajes[index].nombre),
              onTap: () {
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
          ));
        } else if (index == personajes.length && isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(child: Text("No hay más datos")),
          );
        }
      },
    );
  }

  static Widget cardListViewFavoritos(List<Personaje> personajes) {
    List<int> id = [];
    return ListView.builder(
      itemCount: personajes.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < personajes.length) {
          final personaje = personajes[index];

          for (var item in personajes) {
            id.add(int.parse(item.id));
          }

          idMayor =
              id.reduce((value, element) => value > element ? value : element);
          print(idMayor);
          return Card(
              //shape: ,
              child: Container(
            alignment: AlignmentDirectional.center,
            height: 100,
            child: ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(personajes[index].imgPixel)),
                trailing: _seleccionarCardUsuario(personajes[index],
                    context.read<PersonajesProvider>().usuario, context),
                title: Text(personajes[index].nombre),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerPersonajeUser(personaje),
                    ),
                  );
                }),
          ));
        }
      },
    );
  }
}
