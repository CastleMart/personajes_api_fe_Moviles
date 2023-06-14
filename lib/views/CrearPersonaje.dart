import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/TextFieldBase.dart';
import 'package:personajes_api_fe/common/enums.dart';
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
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    PersonajeController con = PersonajeController();
    Future<List<Personaje>> personajes = PersonajeController.getPersonajes();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Introducir nuevo personaje'),
        ),
        body: Form(
          key: keyForm,
          child: ListView(
            children: [
              TextFieldBase(
                "Nombre",
                nombreText,
                validateText: ValidateText.name,
              ),
              TextFieldBase("Fuerza", fuerzaText,
                  validateText: ValidateText.numValue),
              TextFieldBase("Defensa", defenzaText,
                  validateText: ValidateText.numValue),
              TextFieldBase("Imagen", imgText),
              ElevatedButton(
                  onPressed: () {
                    if (keyForm.currentState!.validate()) {
                      con.crearPersonaje(
                          new Personaje(
                              (this.mayorId + 1).toString(),
                              nombreText.text,
                              fuerzaText.text,
                              defenzaText.text,
                              imgText.text),
                          context);
                    }

                    //Navigator.pop(context);
                  },
                  child: Text("Agregar"))
            ],
          ),
        ));
  }

  guardar() {}
}
