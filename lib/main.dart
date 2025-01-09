
import 'package:flutter/material.dart';
import 'package:taller/screens/Bienvenida.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:taller/screens/catalogo.dart';
import 'firebase_options.dart';


void main() async {
  // Asegura que los widgets estén inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ejecuta la aplicación
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