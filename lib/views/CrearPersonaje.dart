import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/CartasPersonajes.dart';
import 'package:personajes_api_fe/Herramientas/TextFieldBase.dart';
import 'package:personajes_api_fe/common/enums.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';

import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/PantallaPrincipal.dart';

//void main() => runApp(const MyApp());

class CrearPersonaje extends StatelessWidget {
  //final int mayorId;

  const CrearPersonaje({super.key});

  @override
  Widget build(BuildContext context) {
    //Inicialización de los controladores necesarios para llenar los campos.
    TextEditingController nombreText = TextEditingController(text: "");
    TextEditingController fuerzaText = TextEditingController(text: "");
    TextEditingController defenzaText = TextEditingController(text: "");
    TextEditingController imgText = TextEditingController(text: "");
    TextEditingController imgPixelText = TextEditingController(text: "");
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    PersonajeController con = PersonajeController();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Introducir nuevo personaje'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
              key: keyForm,
              child: ListView(
                children: [
                  //* Recibimiento de los textos de los campos.
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
                          await con.crearPersonaje(
                              Personaje(
                                  (CartasPersonajes.idMayor + 1).toString(),
                                  nombreText.text,
                                  fuerzaText.text,
                                  defenzaText.text,
                                  imgText.text,
                                  false,
                                  imgPixel: imgPixelText.text),
                              context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PantallaPrincipal()),
                          );
                        }

                        //Navigator.pop(context);
                      },
                      child: Text("Agregar"))
                ],
              ),
            )));
  }
}
