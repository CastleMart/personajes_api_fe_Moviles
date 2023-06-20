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

///Clase que se dedica a realizar las acciones para iniciar sesión.
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Inicialización de los controladores necesarios para llenar los campos.
  TextEditingController userText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  PersonajeController con = PersonajeController();
  UsuariosController userCon = UsuariosController();
  bool verificar = false;

  @override
  void initState() {
    super.initState();
    userText.text = "";
    passwordText.text = "";
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
                key: keyForm,
                child: ListView(children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //Vista del avatar de la aplicación
                    children: [
                      const CircleAvatar(
                        radius: 100.0,
                        backgroundImage: NetworkImage(
                            "https://i.pinimg.com/474x/12/56/de/1256def18416a032b0a118a0965714bd--identity-design-design-logos.jpg"),
                      ),
                      //Visualización de los campos
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
                        //* Al precionarse el botón, se realizan las validaciones
                        //* necesarias para inicar sesión.
                        child: ElevatedButton(
                            onPressed: () async {
                              if (await userCon.verificarPassword(
                                  userText.text, passwordText.text)) {
                                context
                                    .read<PersonajesProvider>()
                                    .setTipoUsuario(
                                        UsuariosController.getEsAdmin());
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
