import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/personajes_provider.dart';

/// Clase que crear un widget de confirmación de acción para un uso
/// general de la aplicación
class ConfirmActionButton extends StatefulWidget {
  final Function onPressed;
  const ConfirmActionButton({super.key, required this.onPressed});

  @override
  State<ConfirmActionButton> createState() => _ConfirmActionButtonState();
}

class _ConfirmActionButtonState extends State<ConfirmActionButton> {
  @override
  Widget build(BuildContext context) {
    /// Se retorna un widget de tipo TextButton el cual recibe una función
    /// para poder realizar cualquier acción que se le mando por el parámetro
    return TextButton(
        onPressed: () => {
              widget.onPressed(),
              context.read<PersonajesProvider>().obtenerPersonaje(),
              Navigator.pop(context)
            },
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color.fromARGB(255, 104, 14, 14)),
        child: const Text("Aceptar"));
  }
}
