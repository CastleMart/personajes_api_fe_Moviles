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

class ActualizarPersonaje extends StatefulWidget {
  final Personaje personaje;

  const ActualizarPersonaje(this.personaje, {super.key});

  @override
  State<ActualizarPersonaje> createState() => _ActualizarPersonajeState();
}

class _ActualizarPersonajeState extends State<ActualizarPersonaje> {
  TextEditingController nombreText = TextEditingController();
  TextEditingController fuerzaText = TextEditingController();
  TextEditingController defenzaText = TextEditingController();
  TextEditingController imgPixelText = TextEditingController();
  TextEditingController imgText = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  PersonajeController con = PersonajeController();

  @override
  void initState() {
    super.initState();
    nombreText.text = widget.personaje.nombre;
    fuerzaText.text = widget.personaje.fuerza;
    defenzaText.text = widget.personaje.defenza;
    imgPixelText.text = widget.personaje.imgPixel;
    imgText.text = widget.personaje.img;
  }

  @override
  Widget build(BuildContext context) {
    //Controladores para recibir los campos

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
                                this.widget.personaje.id,
                                nombreText.text,
                                fuerzaText.text,
                                defenzaText.text,
                                imgText.text,
                                false,
                                imgPixel: imgPixelText.text),
                            context);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Agregar"))
              ],
            ),
          )),
    );
  }
}
