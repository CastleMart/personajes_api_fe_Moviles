//import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:personajes_api_fe/controllers/UsuariosController.dart';

import 'package:personajes_api_fe/providers/personajes_provider.dart';
import 'package:personajes_api_fe/views/login.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => PersonajesProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

//-----------------------------------------------------------------------------------------------------------------------------
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    UsuariosController con = UsuariosController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi aplicación',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(body: Login()),
    );
  }
}
