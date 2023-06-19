import 'package:flutter/cupertino.dart';
import 'package:personajes_api_fe/providers/personajes_provider.dart';
import 'package:provider/provider.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({super.key});

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(context.watch<PersonajesProvider>().usuario.nombre));
  }
}
