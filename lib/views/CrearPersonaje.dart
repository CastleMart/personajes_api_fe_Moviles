import 'package:flutter/material.dart';

//void main() => runApp(const MyApp());

class CrearPersonaje extends StatelessWidget {
  const CrearPersonaje({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Introducir nuevo personaje'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
