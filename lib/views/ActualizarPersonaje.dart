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
    //Controladores para recibir los campos
    TextEditingController nombreText =
        TextEditingController(text: this.personaje.nombre);
    TextEditingController fuerzaText =
        TextEditingController(text: this.personaje.fuerza);
    TextEditingController defenzaText =
        TextEditingController(text: this.personaje.defenza);
    TextEditingController imgPixelText =
        TextEditingController(text: this.personaje.imgPixel);
    TextEditingController imgText =
        TextEditingController(text: this.personaje.img);
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    PersonajeController con = PersonajeController();

    return Scaffold(
      //TODO: Corregir bug del teclado
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Actualizar personaje'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: keyForm,
            child: ListView(
              children: [
                //Utilización de un método creado para las validaciones.
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
                TextFieldBase("Pixel Art", imgPixelText),
                ElevatedButton(
                    onPressed: () async {
                      if (keyForm.currentState!.validate()) {
                        await con.actualizarPersonaje(
                            Personaje(
                                this.personaje.id,
                                nombreText.text,
                                fuerzaText.text,
                                defenzaText.text,
                                imgText.text,
                                false,
                                imgPixel: imgPixelText.text),
                            context);
                      }

                      Navigator.pop(context);
                    },
                    child: Text("Agregar"))
              ],
            ),
          )),
    );
  }
}
