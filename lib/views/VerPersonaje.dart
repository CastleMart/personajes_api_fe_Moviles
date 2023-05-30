import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/ActualizarPersonaje.dart';

import '../disenios.dart';

//void main() => runApp(const VerPersonaje());

class VerPersonaje extends StatelessWidget {
  final Personaje personaje;

  const VerPersonaje(this.personaje, {super.key});
  @override
  Widget build(BuildContext context) {
    PersonajeController con = new PersonajeController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
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
              Disenios.atributosPersonaje("Nombre", personaje.nombre, 8.0),
              Disenios.atributosPersonaje("Fuerza", personaje.fuerza, 8.0),
              Disenios.atributosPersonaje("Defenza", personaje.defenza, 8.0),
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
                                    ActualizarPersonaje(personaje)));
                      },
                      child: Text("Editar")),
                  ElevatedButton(
                      onPressed: () {
                        con.eliminarPersonaje(personaje.id, context);
                        //Navigator.pop(context);
                      },
                      child: Text("Borrar")),
                ],
              ),
            ],
          ),
        ],
      ))),
    );
  }
}
