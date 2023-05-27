import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/disenios.dart';
import 'package:personajes_api_fe/models/personaje.dart';

//void main() => runApp(const MyApp());

class CrearPersonaje extends StatelessWidget {
  const CrearPersonaje({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreText = TextEditingController(text: "");
    TextEditingController fuerzaText = TextEditingController(text: "");
    TextEditingController defenzaText = TextEditingController(text: "");
    TextEditingController imgText = TextEditingController(text: "");
    PersonajeController con = PersonajeController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Introducir nuevo personaje'),
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
                con.crearPersonaje(new Personaje("a8", nombreText.text,
                    fuerzaText.text, defenzaText.text, imgText.text));
              },
              child: Text("Botoncito"))
        ],
      )),
    );
  }
}
