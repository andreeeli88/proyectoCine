import 'dart:convert';
import 'package:flutter/services.dart'; // Para cargar archivos locales
import 'package:flutter/material.dart';
import 'package:taller/screens/buscador.dart';
import 'package:taller/screens/reproductor.dart';
import 'package:url_launcher/url_launcher.dart'; // Importa el paquete para lanzar URLs

class Catalogo extends StatelessWidget {
  const Catalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catálogo de Videos"),
      ),
      body: Column(
        children: [
          Text("Esta es la cartelera", style: TextStyle(fontSize: 18)),
          buscador(context),
          Expanded(child: lista("assets/data/peliculas.json")),
        ],
      ),
    );
  }
}

// Modificamos la función para cargar el JSON desde los assets
Future<List> leer(String path) async {
  try {
    final String response = await rootBundle.loadString(path);
    final List data = json.decode(response); // Decodificamos como una lista de objetos

    print("Datos cargados desde el archivo JSON: $data");

    return data; // Retornamos la lista de objetos
  } catch (e) {
    print("Error al cargar o procesar el archivo JSON: $e");
    throw Exception("Error al cargar el archivo JSON.");
  }
}

Widget lista(String path) {
  return FutureBuilder(
    future: leer(path),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      }

      if (snapshot.hasData) {
        final data = snapshot.data!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre de la película
                  Text("${item['name']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  // Imagen de la película
                  Image.network(
                    item['img'], // Usamos la URL de la imagen
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 8),
                  // Título del video y botón para ver
                  ElevatedButton(
                    onPressed: () {
                      // Pasamos la URL del video al reproductor
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Reproductor(videoUrl: item['url']),
                        ),
                      );
                    },
                    child: Text("Reproducir"),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return Center(child: Text("No hay datos disponibles"));
      }
    },
  );
}

// Función para lanzar el URL
Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunch(uri.toString())) {
    await launch(uri.toString());
  } else {
    throw 'No se puede abrir la URL: $url';
  }
}

Widget buscador(context) {
  return ElevatedButton(
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Buscador()),
    ),
    child: Text("Ir al buscador"),
  );
}
