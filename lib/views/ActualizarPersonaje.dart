import 'package:flutter/material.dart';
import 'package:personajes_api_fe/main.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/VerPersonaje.dart';
import 'package:provider/provider.dart';

import '../Herramientas/TextFieldBase.dart';
import '../common/enums.dart';
import '../controllers/PersonajeController.dart';

import '../providers/personajes_provider.dart';

//void main() => runApp(const MyApp());

class ActualizarPersonaje extends StatelessWidget {
  final Personaje personaje;

  const ActualizarPersonaje(this.personaje, {super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
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
          title: const Text('Actualizar personaje'),
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
                      con.actualizarPersonaje(
                          Personaje(
                              this.personaje.id,
                              nombreText.text,
                              fuerzaText.text,
                              defenzaText.text,
                              imgText.text,
                              false),
                          context);
                    }

                    Navigator.pop(context);
                  },
                  child: Text("Agregar"))
            ],
          ),
        ));
  }
}
