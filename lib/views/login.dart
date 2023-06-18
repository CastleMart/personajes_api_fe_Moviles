import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/disenios.dart';
import 'package:personajes_api_fe/controllers/UsuariosController.dart';
import 'package:personajes_api_fe/views/PantallaPrincipal.dart';
import 'package:personajes_api_fe/views/SingUp.dart';
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
    UsuariosController userCon = UsuariosController();
    bool verificar = false;

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
                        'Ingresar',
                        style: TextStyle(fontFamily: 'Arial', fontSize: 50.0),
                      ),
                      TextFieldBase(
                        "Usuario",
                        userText,
                        validateText: ValidateText.user,
                      ),
                      TextFieldBase("Contraseña", passwordText,
                          validateText: ValidateText.password),
                      SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (await userCon.verificarPassword(
                                  userText.text, passwordText.text)) {
                                context
                                    .read<PersonajesProvider>()
                                    .setTipoUsuario(userCon.getEsAdmin());
                                context.read<PersonajesProvider>().setUsuarios(
                                    await userCon.getUsuario(userText.text));

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaPrincipal()));
                              } else {
                                Disenios.verBarraAccion(
                                    "Contraseña o usuario incorrecto", context);
                              }
                              // ! Checar bien código
                              //if (keyForm.currentState!.validate()) {}
                            },
                            child: const Text(
                              "Entrar",
                              style: TextStyle(fontSize: 30.0),
                            )),
                      ),
                      TextButton(
                          onPressed: () => {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingUp()))
                              },
                          child: Text("Regístrate"))
                    ],
                  )
                ]))));
  }
}
