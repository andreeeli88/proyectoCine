import 'package:flutter/material.dart';
import 'package:taller/screens/catalogo.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Correo electrónico",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
           /* ElevatedButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;


                if (email.isNotEmpty && password.isNotEmpty) {
             
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Bienvenido, $email")),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Por favor, llena todos los campos")),
                  );
                }
              },
              child: const Text("Iniciar sesión"),
              
            ),*/
            boton1(context)
          ],
        ),
      ),
    );
  }
}
Widget boton1(context){
  return ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> Catalogo() )), child: Text("Ingrese"));
}