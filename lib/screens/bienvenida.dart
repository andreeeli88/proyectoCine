import 'package:flutter/material.dart';
import 'package:taller/screens/login.dart';
import 'package:taller/screens/registro.dart';

class Bienvenida extends StatelessWidget {
  const Bienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Fondo de la appBar
        title: Center(
          child: Text(
            "Bienvenido",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              login_btn(context),
              SizedBox(height: 15),  // Espaciado entre los botones
              registro_btn(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget login_btn(BuildContext context) {
  return Container(
    width: double.infinity,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal, // Color del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
        padding: EdgeInsets.symmetric(vertical: 15), // Padding dentro del botón
        elevation: 5, // Sombra del botón
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      ),
      label: Text(
        "Iniciar sesión",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white, // Color del texto
        ),
      ),
      icon: Icon(
        Icons.account_circle,
        color: Colors.white, // Color del ícono
      ),
    ),
  );
}

Widget registro_btn(BuildContext context) {
  return Container(
    width: double.infinity,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent, // Color del botón
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Bordes redondeados
        ),
        padding: EdgeInsets.symmetric(vertical: 15), // Padding dentro del botón
        elevation: 5, // Sombra del botón
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registro()),
      ),
      label: Text(
        "Registrarse",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white, // Color del texto
        ),
      ),
      icon: Icon(
        Icons.account_circle_outlined,
        color: Colors.white, // Color del ícono
      ),
    ),
  );
}
