import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Herramientas/Botones.dart';
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
  //late Future<List<Personaje>> personajes;
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
        //resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Personajes Fire Emblem"),
          actions: [
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
    )
        //child: Center(
        //    child: CircularProgressIndicator(backgroundColor: Colors.white))
        ;
  }
}
