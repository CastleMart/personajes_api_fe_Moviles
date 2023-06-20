import 'package:flutter/material.dart';

//! Deprecate
class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: const <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Guillermo García"),
          accountEmail: Text("email@prueba.es"),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
          decoration: BoxDecoration(
            color: Colors.red,
          ),
        ),
        ListTile(
          title: Text('Primero elemento!'),
          leading: Icon(Icons.home),
        ),
        ListTile(
          title: Text('Segundo elemento!'),
          leading: Icon(Icons.settings),
        ),
      ],
    ));
  }
}
