import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/pokemon_model.dart';
import 'ScaffoldWidget/pokemon_detail_screen.dart';

class PokeScreen extends StatefulWidget {
  const PokeScreen({super.key});

  @override
  State<PokeScreen> createState() => _PokeScreenState();
}

class _PokeScreenState extends State<PokeScreen> {
  final String apiUrl = "https://pokeapi.co/api/v2/pokemon?limit=20";
  late Future<List<Pokemon>> futurePokemons;
  @override
  void initState() {
    super.initState();
    futurePokemons = fetchPokemons();
  }

  Future<List<Pokemon>> fetchPokemons() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body)['results'];
      return data.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('Feild to load Pokemons');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Pokedex', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: futurePokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error : ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Pokemons found'));
          }
          final pokemons = snapshot.data!;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Image.network(
                          pokemon.imageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        pokemon.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
