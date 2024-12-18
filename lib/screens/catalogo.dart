
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:taller/screens/buscador.dart';

class Catalogo extends StatelessWidget {
  const Catalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Column(
      children: [
        Text("Esta es la cartelera"),
        buscador(context),
        Expanded(child: lista("https://jritsqmet.github.io/web-api/peliculas1.json"))
      ],
     ),
    );
  }
}
Future <List> leer(url) async{
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200){
    return json.decode(response.body)['peliculas'];
  }else{
    throw Exception("error");
  }
}
Widget lista (url){
  return FutureBuilder(future: leer(url), builder: (context, snapshot){
    if(snapshot.hasData){
      final data = snapshot.data!;
      return ListView.builder(itemCount: data.length, itemBuilder:(context, index) {
         final item = data[index];
         return ListTile(
        title: Column(
          children: [
            Text("${item['titulo']}"),
            Image.network(item['imagen'] ?? item['image'], width: 100,)

          ],
        ),
      );
      },);
     
    }else{
      return Text("Data no econtrada");
    }
  } );
}
Widget buscador(context){
  return ElevatedButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> Buscador())), child: Text("Ir la buscador"));
}