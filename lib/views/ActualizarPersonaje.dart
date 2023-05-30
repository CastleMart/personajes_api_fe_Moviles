import 'package:flutter/material.dart';
import 'package:personajes_api_fe/main.dart';
import 'package:personajes_api_fe/models/personaje.dart';

import '../controllers/PersonajeController.dart';
import '../disenios.dart';

//void main() => runApp(const MyApp());

class ActualizarPersonaje extends StatelessWidget {
  final Personaje personaje;

  const ActualizarPersonaje(this.personaje, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreText =
        TextEditingController(text: this.personaje.nombre);
    TextEditingController fuerzaText =
        TextEditingController(text: this.personaje.fuerza);
    TextEditingController defenzaText =
        TextEditingController(text: this.personaje.defenza);
    TextEditingController imgText =
        TextEditingController(text: this.personaje.img);
    PersonajeController con = PersonajeController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Center(
          child: Column(
        children: [
          Disenios.fieldTextDatoPersonaje(nombreText, "Nombre"),
          Disenios.fieldTextDatoPersonaje(fuerzaText, "Fuerza"),
          Disenios.fieldTextDatoPersonaje(defenzaText, "Defenza"),
          Disenios.fieldTextDatoPersonaje(imgText, "URL Imagen"),
          ElevatedButton(
              onPressed: () {
                con.actualizarPersonaje(
                    Personaje(this.personaje.id, nombreText.text,
                        fuerzaText.text, defenzaText.text, imgText.text),
                    context);
              },
              child: Text("Actualizar"))
        ],
      )),
    );
  }
}
