import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Opciones extends StatelessWidget {
  const Opciones({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Opciones')),
        body: Center(
            child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              color: Colors.blue,
              child: Column(children: [
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Colors.grey,
                ),
                Title(color: Colors.black, child: Text("Nombre de usuario")),
                Text("Mario Castillo"),
                Title(color: Colors.black, child: Text("Nombre de usuario")),
                Text("Mario Castillo")
              ]),
            ),
            tarjetas(
              Icon(Icons.home),
            ),
            tarjetas(
              Icon(Icons.home),
            ),
            tarjetas(
              Icon(Icons.home),
            ),
            tarjetas(
              Icon(Icons.home),
            )
          ],
        ))

        //listVie children: [tarjetas(), tarjetas()],
        );
  }

  tarjetas(Icon icono) {
    return Container(
        //elevation: 8,
        //color: Colors.greenAccent,
        //shadowColor: Colors.purple,
        //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ))),
            child: icono,
            onPressed: () => {},
          ),
        ));
  }
}
