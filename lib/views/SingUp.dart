import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/disenios.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import 'package:personajes_api_fe/views/login.dart';

import '../Herramientas/TextFieldBase.dart';
import '../common/enums.dart';
import '../controllers/PersonajeController.dart';
import '../controllers/UsuariosController.dart';

class SingUp extends StatelessWidget {
  const SingUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userText = TextEditingController(text: "");
    TextEditingController nombreText = TextEditingController(text: "");
    TextEditingController passwordText = TextEditingController(text: "");
    TextEditingController passwordRepiteText = TextEditingController(text: "");
    GlobalKey<FormState> keyForm = GlobalKey<FormState>();
    UsuariosController conUsuario = UsuariosController();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
                key: keyForm,
                child: ListView(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 100.0,
                        backgroundColor: Colors.grey,
                      ),
                      Text(
                        'Regístrate',
                        style: TextStyle(fontFamily: 'Arial', fontSize: 50.0),
                      ),
                      TextFieldBase(
                        "Usuario",
                        userText,
                        validateText: ValidateText.user,
                      ),
                      TextFieldBase(
                        "Nombre Completo",
                        nombreText,
                        validateText: ValidateText.name,
                      ),
                      TextFieldBase("Contraseña", passwordText,
                          validateText: ValidateText.password),
                      TextFieldBase("Repetir Contraseña", passwordRepiteText,
                          validateText: ValidateText.password),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (keyForm.currentState!.validate()) {
                                if (passwordText.text !=
                                    passwordRepiteText.text) {
                                  Disenios.verBarraAccion(
                                      "No coinciden las dos contraseñas",
                                      context);
                                  passwordRepiteText.text = "";
                                  passwordText.text = "";
                                }

                                if (await UsuariosController.existeUsuario(
                                    userText.text)) {
                                  Disenios.verBarraAccion(
                                      "Ya existe el usuario, pruebe con otro.",
                                      context);
                                  passwordRepiteText.text = "";
                                  passwordText.text = "";
                                } else {
                                  Usuario usuario = Usuario(
                                      userText.text, nombreText.text,
                                      password: passwordText.text);
                                  conUsuario.crearUsuario(usuario, context);

                                  Disenios.verBarraAccion(
                                      "Usuario Creado Exitosamente", context);

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                }
                              }
                            },
                            child: Text(
                              "Registrar",
                              style: TextStyle(fontSize: 30.0),
                            )),
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()))
                              },
                          child: Text("Ingresar"))
                    ],
                  )
                ]))));
  }
}
