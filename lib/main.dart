//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/models/personaje.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  PersonajeController connect = new PersonajeController();
  late Future<List<Personaje>> personajes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personajes = connect.getPersonajes();
  }

  @override
  Widget build(BuildContext context) {
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
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Personajes Fire Emblem"),
          ),
          body: FutureBuilder(
            future: personajes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: _listaPersonajes(snapshot.requireData),
                );
              } else if (snapshot.hasError) {
                return Text("Error");
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ));
  }

  List<Widget> _listaPersonajes(List<Personaje> datos) {
    List<Widget> personajesWid = [];

    for (var item in datos) {
      personajesWid.add(Card(
          child: Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: Text(item.nombre)),
        ],
      )));
    }

    return personajesWid;
  }
}

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
}
