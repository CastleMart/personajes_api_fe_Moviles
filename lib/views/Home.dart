import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Herramientas/Buscador.dart';
import '../Herramientas/CartasPersonajes.dart';
import '../controllers/PersonajeController.dart';
import '../models/personaje.dart';
import '../providers/personajes_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PersonajeController connect = PersonajeController();
  final controller = ScrollController();
  late List<Personaje> personajesList = [];
  late List<Personaje> personajesListPagina = [];
  int numPagina = 1;
  int numElementos = 7;
  bool _isLoading = true;
  bool _isLoadingScroll = true;

  @override
  void initState() {
    super.initState();
    numPagina = 1;
    obtenerPersonajes();
    //paginarElementos();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        setState(() {
          numPagina++;
          paginarElementos();
        });
      }
    });
  }

  ///Método que realiza la lógina de la paginación de los elementos.
  paginarElementos() {
    int cantidadListaTotal = personajesList.length;
    //int cantidadListaPagina = personajesListPagina.length;
    int elementosMostrar = numElementos * numPagina;
    if (elementosMostrar < cantidadListaTotal) {
      for (var i = elementosMostrar - numElementos; i < elementosMostrar; i++) {
        personajesListPagina.add(personajesList[i]);
      }
    } else {
      int sobrante = cantidadListaTotal - elementosMostrar + numElementos;
      for (var i = elementosMostrar - numElementos;
          i < cantidadListaTotal;
          i++) {
        personajesListPagina.add(personajesList[i]);
      }
    }

    _isLoadingScroll = personajesListPagina.length < cantidadListaTotal;
  }

  ///Método que obtiene los perosnajes y
  ///actualiza el estado si se está leyendo o no contenido
  Future<void> obtenerPersonajes() async {
    try {
      numPagina = 1;
      personajesListPagina.clear();
      personajesList = await connect.getPersonajes();
      paginarElementos();
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi aplicación',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personajes de Fire Emblem"),
          actions: [
            //* Utilización del buscador
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Buscador());
                },
                icon: Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                backgroundColor: Colors.purple,
                color: Colors.white,
                displacement: 20.0,
                strokeWidth: 4,
                //*Impresión de la lista de cartas de los personajes.
                child: CartasPersonajes.cardListView(
                    personajesListPagina,
                    context.read<PersonajesProvider>().esAdmin,
                    controller,
                    _isLoadingScroll),
                onRefresh: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await obtenerPersonajes();
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
      ),
    );
  }
}
