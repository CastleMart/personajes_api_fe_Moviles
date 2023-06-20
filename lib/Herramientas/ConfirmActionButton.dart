import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/personajes_provider.dart';

/// Clase que crear un widget de confirmación de acción
class ConfirmActionButton extends StatefulWidget {
  final Function onPressed;
  const ConfirmActionButton({super.key, required this.onPressed});

  @override
  State<ConfirmActionButton> createState() => _ConfirmActionButtonState();
}

class _ConfirmActionButtonState extends State<ConfirmActionButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => {
              widget.onPressed(),
              context.read<PersonajesProvider>().obtenerPersonaje(),
              Navigator.pop(context)
            },
        style: TextButton.styleFrom(
            foregroundColor: Color.fromARGB(255, 255, 255, 255),
            backgroundColor: Color.fromARGB(255, 148, 27, 79)),
        child: const Text("Aceptar"));
  }
}
