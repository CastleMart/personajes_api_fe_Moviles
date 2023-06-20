import 'dart:core';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Favoritos.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/controllers/UsuariosController.dart';
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

//--------------------------------------------------

  ///Verifica qué tipo de usuario es el que ingresó a la aplicación y muestra
  ///opciones según sea el caso.
  ///
  ///Esta función que recibe un [Personaje] y un [BuildContext].
  ///
  ///Esta función retorna un [Widget].
  static Widget _seleccionarCardUsuario(
      Personaje personaje, Usuario usuario, BuildContext context) {
    final favoritos = usuario.favoritos;
    final esAdmin = context.watch<PersonajesProvider>().esAdmin;

    if (esAdmin) {
      return IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActualizarPersonaje(personaje),
            ),
          );
        },
        icon: Icon(
          Icons.edit,
          color: Colors.purple,
        ),
      );
    } else {
      final isFavorito = favoritos.contains(personaje.id);

      return BotonFavorito(
        true, // Puedes ajustar la visibilidad según tus necesidades
        personaje,
        usuario,
        key: ValueKey(personaje
            .id), // Utiliza un ValueKey único para el widget BotonFavorito
      );
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
              color: Color.fromARGB(255, 241, 233, 248),
              shadowColor: Color.fromARGB(255, 65, 188, 67),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.purple.shade300),
              ),
              //shape: ,
              child: Container(
                alignment: AlignmentDirectional.center,
                height: 100,
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.yellow[50],
                      backgroundImage:
                          NetworkImage(personajes[index].imgPixel)),
                  trailing: _seleccionarCardUsuario(personajes[index],
                      context.read<PersonajesProvider>().usuario, context),
                  title: Text(
                    personajes[index].nombre,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
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
              color: Color.fromARGB(255, 182, 192, 253),
              shadowColor: Color.fromARGB(255, 65, 188, 67),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.purple.shade300),
              ),
              child: Container(
                alignment: AlignmentDirectional.center,
                height: 100,
                child: ListTile(
                    leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.yellow[50],
                        backgroundImage:
                            NetworkImage(personajes[index].imgPixel)),
                    trailing: _seleccionarCardUsuario(personajes[index],
                        context.read<PersonajesProvider>().usuario, context),
                    title: Text(
                      personajes[index].nombre,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
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

class BotonFavorito extends StatefulWidget {
  final bool visible;
  final Personaje personaje;
  final Usuario usuario;

  const BotonFavorito(this.visible, this.personaje, this.usuario,
      {required Key key})
      : super(key: key);

  @override
  State<BotonFavorito> createState() => _BotonFavoritoState();
}

class _BotonFavoritoState extends State<BotonFavorito> {
  bool isFavorito = false;

  @override
  void initState() {
    super.initState();
    isFavorito = widget.usuario.favoritos.contains(widget.personaje.id);
  }

  Future<void> toggleFavorito() async {
    final favoritos = widget.usuario.favoritos;
    if (isFavorito) {
      favoritos.remove(widget.personaje.id);
    } else {
      favoritos.add(widget.personaje.id);
    }
    await UsuariosController.putFavoritos(
        widget.usuario.nombreUsuario, favoritos);
    setState(() {
      isFavorito = !isFavorito;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: IconButton(
        onPressed: toggleFavorito,
        icon: Icon(
          isFavorito ? Icons.star : Icons.star_border,
          color: Colors.orange[600],
        ),
      ),
    );
  }
}
