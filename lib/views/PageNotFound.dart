import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Not Found'),
      ),
      body: Center(
        child: Text(
          '404 - Page not found',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
