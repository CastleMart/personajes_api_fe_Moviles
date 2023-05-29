import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/disenios.dart';
import 'package:personajes_api_fe/models/personaje.dart';

//void main() => runApp(const MyApp());

class CrearPersonaje extends StatelessWidget {
  final int mayorId;

  const CrearPersonaje(this.mayorId, {super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nombreText = TextEditingController(text: "");
    TextEditingController fuerzaText = TextEditingController(text: "");
    TextEditingController defenzaText = TextEditingController(text: "");
    TextEditingController imgText = TextEditingController(text: "");
    PersonajeController con = PersonajeController();
    Future<List<Personaje>> personajes = con.getPersonajes();

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
                con.crearPersonaje(
                    new Personaje(
                        (this.mayorId + 1).toString(),
                        nombreText.text,
                        fuerzaText.text,
                        defenzaText.text,
                        imgText.text),
                    context);

                Navigator.pop(context);
              },
              child: Text("Ingresar"))
        ],
      )),
    );
  }
}
