import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/views/PantallaPrincipal.dart';
import 'package:provider/provider.dart';

import '../Herramientas/TextFieldBase.dart';
import '../common/enums.dart';
import '../controllers/PersonajeController.dart';
import '../providers/personajes_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userText = TextEditingController(text: "");
    TextEditingController passwordText = TextEditingController(text: "");
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    PersonajeController con = PersonajeController();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Form(
                key: keyForm,
                child: ListView(
                  children: [
                    Text(
                      'Entrar',
                      style: TextStyle(fontFamily: 'Arial', fontSize: 50.0),
                    ),
                    TextFieldBase(
                      "Usuario",
                      userText,
                      validateText: ValidateText.name,
                    ),
                    TextFieldBase("Contraseña", passwordText,
                        validateText: ValidateText.numValue),
                    ElevatedButton(
                        onPressed: () {
                          if (userText.text == "a") {
                            context
                                .read<PersonajesProvider>()
                                .cambiarTipoUsuario();
                          }
                          if (keyForm.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PantallaPrincipal()));
                          }

                          //Navigator.pop(context);
                        },
                        child: Text("Entrar"))
                  ],
                ))));
  }
}
