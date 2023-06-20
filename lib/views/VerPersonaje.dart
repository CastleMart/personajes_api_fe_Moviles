import 'package:flutter/material.dart';
import 'package:personajes_api_fe/Herramientas/Botones.dart';
import 'package:personajes_api_fe/Herramientas/CartasPersonajes.dart';
import 'package:personajes_api_fe/controllers/PersonajeController.dart';
import 'package:personajes_api_fe/models/personaje.dart';
import 'package:personajes_api_fe/views/ActualizarPersonaje.dart';

import '../Herramientas/disenios.dart';

//void main() => runApp(const VerPersonaje());

class VerPersonaje extends StatefulWidget {
  final Personaje personaje;

  const VerPersonaje(this.personaje, {super.key});

  @override
  State<VerPersonaje> createState() => _VerPersonajeState();
}

class _VerPersonajeState extends State<VerPersonaje> {
  late String personajeId;
  late Future<Personaje> per;
  bool _isLoading = true;
  late AsyncSnapshot<Personaje> snapshotGlobal;

  @override
  void initState() {
    super.initState();
    personajeId = widget.personaje.id;

    setState(() {
      try {
        per = PersonajeController.getPersonajeId(personajeId);
      } catch (e) {
        Navigator.pop(context);
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PersonajeController con = new PersonajeController();
    //print(con.getPersonajeId(personaje.id, context));
    Personaje personaje;
    return Visibility(
        visible: _isLoading,
        replacement: Scaffold(
            appBar: AppBar(
              title: const Text('Detalles del personaje'),
            ),
            body: FutureBuilder<Personaje>(
              future: per,
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  snapshotGlobal = snapshot;
                  personaje = snapshot.requireData;
                  return _mostarDatos(personaje);
                } else if (snapshot.hasError) {
                  return Text("Error");
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
        child: const Center(
            child: CircularProgressIndicator(backgroundColor: Colors.purple)));
  }

  _mostarDatos(Personaje personaje) {
    return Center(
      child: Container(
          //height: 600,
          child: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(25),
            color: Color.fromARGB(255, 212, 217, 246),
            //shadowColor: Color.fromARGB(255, 65, 188, 67),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.purple.shade300),
            ),
            child: Expanded(
              child: Image.network(
                personaje.img,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  // Error handling code goes here
                  return Text('Imagen no encontrada');
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 25),
            color: Color.fromARGB(255, 212, 217, 246),
            //shadowColor: Color.fromARGB(255, 65, 188, 67),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.purple.shade300),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    personaje.nombre,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Disenios.atributosPersonaje("Fuerza", personaje.fuerza, 8.0),
                  Disenios.atributosPersonaje(
                      "Defensa", personaje.defensa, 8.0),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ActualizarPersonaje(personaje)));
                          setState(() {
                            _isLoading = true;

                            per =
                                PersonajeController.getPersonajeId(personajeId);
                            personaje = snapshotGlobal.requireData;
                            _mostarDatos(personaje);
                            _isLoading = false;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Botones.botonEliminarPersonaje(context, personaje.id),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
