import 'package:flutter/material.dart';

/// Clase que crear un widget de cancelación de acción para un uso
/// general de la aplicación
class CancelActionButton extends StatefulWidget {
  const CancelActionButton({super.key});

  @override
  State<CancelActionButton> createState() => _CancelActionButtonState();
}

class _CancelActionButtonState extends State<CancelActionButton> {
  @override
  Widget build(BuildContext context) {
    /// Se retorna un widget de tipo TextButton el solo devuelve a la pestaña
    /// anterior donde se dió la acción
    return TextButton(
      onPressed: () => Navigator.pop(context),
      style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 77, 66, 99)),
      child: const Text("Cancelar"),
    );
  }
}
