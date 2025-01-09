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
        backgroundColor: Colors.teal, // Color de fondo del AppBar
        title: Text(
          "Catálogo de Videos",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Esta es la cartelera",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            buscador(context),
            Expanded(child: lista("assets/data/peliculas.json")),
          ],
        ),
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
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre de la película
                      Text(
                        "${item['name']}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Imagen de la película
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item['img'], // Usamos la URL de la imagen
                          width: 100,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      // Botón para ver el video
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal, // Color del botón
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Bordes redondeados
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          elevation: 4,
                        ),
                        onPressed: () {
                          // Pasamos la URL del video al reproductor
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reproductor(videoUrl: item['url']),
                            ),
                          );
                        },
                        child: Text(
                          "Reproducir",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
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

Widget buscador(BuildContext context) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal, // Color del botón
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Bordes redondeados
      ),
      padding: EdgeInsets.symmetric(vertical: 12),
      elevation: 4,
    ),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Buscador()),
    ),
    child: Text(
      "Ir al buscador",
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}
