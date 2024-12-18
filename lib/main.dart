
import 'package:flutter/material.dart';
import 'package:taller/screens/Bienvenida.dart';



void main() {
  runApp(const Proyecto());
}

class Proyecto extends StatelessWidget {
  const Proyecto({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Pagina(),
    );
  }
}

class Pagina extends StatelessWidget {
  const Pagina({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Bienvenida(),
    );
  }
}