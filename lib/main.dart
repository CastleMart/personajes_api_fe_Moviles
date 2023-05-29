//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/disenios.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/ActualizarPersonaje.dart';
import 'package:personajes_api_fe/views/CrearPersonaje.dart';
import 'package:personajes_api_fe/views/VerPersonaje.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//-----------------------------------------------------------------------------------------------------------------------------
class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  PersonajeController connect = new PersonajeController();
  late Future<List<Personaje>> personajes;
  int idMayor = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personajes = connect.getPersonajes();
  }

  void _reloadItems() {
    setState(() {
      connect = new PersonajeController();
      personajes = connect.getPersonajes();
    });
  }

  @override
  Widget build(BuildContext context) {
    _reloadItems();

    return MaterialApp(
        title: 'Mi aplicación',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Personajes Fire Emblem"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder(
                    future: personajes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.count(
                          crossAxisCount: 2,
                          children:
                              _listaPersonajes(snapshot.requireData, context),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error");
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                FutureBuilder(
                    builder: (context, sanp) =>
                        _botonCrearPersonaje(context, idMayor)),
                _botonActualizarPagina(),
              ],
            )));
  }

  List<Widget> _listaPersonajes(List<Personaje> datos, context) {
    List<Widget> personajesWid = [];
    List<int> id = [];

    for (var item in datos) {
      //TextEditingController textos = TextEditingController(text: "guau ");
      id.add(int.parse(item.id));
      personajesWid.add(Card(
          child: Column(
        children: [
          //textos.value(TextEditingValue(text: item.nombre)),

          Expanded(
            child: Image.network(
              item.img,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                // Error handling code goes here

                return Text('Imagen no encontrada');
              },
            ),
          ),
          Disenios.atributosPersonaje("Nombre", item.nombre, 2.0),
          Disenios.atributosPersonaje("Fuerza", item.fuerza, 2.0),
          Disenios.atributosPersonaje("Defenza", item.defenza, 2.0),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerPersonaje(item)));
              },
              child: Text("Ver")),
        ],
      )));
    }

    idMayor = id.reduce((value, element) => value > element ? value : element);
    print(idMayor);
    return personajesWid;
  }

  Widget _botonCrearPersonaje(context, idMayorNum) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CrearPersonaje(idMayorNum)));
          },
          child: Text("Ingresar Personaje")),
    );
  }

  Widget _botonActualizarPagina() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            _reloadItems();
          },
          child: Text("Actualizar página")),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Personaje per = Personaje("1", "Lucina", "12", "13");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(per.nombre),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}*/
