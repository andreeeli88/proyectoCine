import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Buscador extends StatefulWidget {
  const Buscador({super.key});

  @override
  _CatalogoState createState() => _CatalogoState();
}

class _CatalogoState extends State<Buscador> {
  List<dynamic> _peliculas = [];
  List<dynamic> _peliculasFiltradas = [];
  String _query = "";

  @override
  void initState() {
    super.initState();
    _cargarPeliculas();
  }

  Future<void> _cargarPeliculas() async {
    const url = "https://jritsqmet.github.io/web-api/peliculas1.json";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          _peliculas = json.decode(response.body)['peliculas'];
          _peliculasFiltradas = _peliculas;
        });
      } else {
        throw Exception("Error al cargar los datos");
      }
    } catch (e) {
      setState(() {
        _peliculas = [];
        _peliculasFiltradas = [];
      });
    }
  }

  void _filtrarPeliculas(String query) {
    setState(() {
      _query = query;
      _peliculasFiltradas = _peliculas.where((pelicula) {
        final titulo = pelicula['titulo'].toString().toLowerCase();
        return titulo.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cartelera")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Buscar película",
                border: OutlineInputBorder(),
              ),
              onChanged: _filtrarPeliculas,
            ),
          ),
          Expanded(
            child: _peliculasFiltradas.isNotEmpty
                ? ListView.builder(
                    itemCount: _peliculasFiltradas.length,
                    itemBuilder: (context, index) {
                      final pelicula = _peliculasFiltradas[index];
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(pelicula['titulo'] ?? "Sin título"),
                            Image.network(
                              pelicula['imagen'] ?? pelicula['image'],
                              width: 100,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(child: Text("No se encontraron películas")),
          ),
        ],
      ),
    );
  }
}
