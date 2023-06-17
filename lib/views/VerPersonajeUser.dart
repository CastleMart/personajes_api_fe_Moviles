import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Botones.dart';
import 'package:personajes_api_fe/Herramientas/CartasPersonajes.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/ActualizarPersonaje.dart';

import '../Herramientas/disenios.dart';

//void main() => runApp(const VerPersonaje());

class VerPersonajeUser extends StatefulWidget {
  final Personaje personaje;

  const VerPersonajeUser(this.personaje, {super.key});

  @override
  State<VerPersonajeUser> createState() => _VerPersonajeUserState();
}

class _VerPersonajeUserState extends State<VerPersonajeUser> {
  late String personajeId;
  late Future<Personaje> per;

  @override
  void initState() {
    super.initState();
    personajeId = widget.personaje.id;

    setState(() {
      per = PersonajeController.getPersonajeId(personajeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    PersonajeController con = new PersonajeController();
    //print(con.getPersonajeId(personaje.id, context));
    Personaje personaje;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalles del personaje'),
        ),
        body: FutureBuilder<Personaje>(
          future: per,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              personaje = snapshot.requireData;
              return Center(
                  child: Card(
                      child: Column(
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
        ));
  }
}
