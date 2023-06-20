import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/disenios.dart';
import 'package:personajes_api_fe/models/Usuario.dart';
import 'package:personajes_api_fe/views/login.dart';

import '../Herramientas/TextFieldBase.dart';
import '../common/enums.dart';
import '../controllers/PersonajeController.dart';
import '../controllers/UsuariosController.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  TextEditingController userText = TextEditingController();
  TextEditingController nombreText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController passwordRepiteText = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  UsuariosController conUsuario = UsuariosController();

  @override
  void initState() {
    super.initState();
    userText.text = "";
    nombreText.text = "";
    passwordText.text = "";
    passwordRepiteText.text = "";
  }

  @override
  Widget build(BuildContext context) {
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
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/474x/12/56/de/1256def18416a032b0a118a0965714bd--identity-design-design-logos.jpg"),
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
                            //TODO: Agregar funcionalidad de registar en la API un usuario.
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
