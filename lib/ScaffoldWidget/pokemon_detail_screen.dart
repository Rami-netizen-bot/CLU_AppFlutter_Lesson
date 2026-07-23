import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lesson_flutter/model/pokemon_model.dart';

class PokemonDetailScreen extends StatefulWidget {
  final Pokemon pokemon;
  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  List<dynamic> stats = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    String searchName = widget.pokemon.name.toLowerCase();
    var url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$searchName');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        stats = jsonData['stats'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.pokemon.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[100],
            padding: EdgeInsets.all(24),
            child: Image.network(
              widget.pokemon.imageUrl,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
          
        ],
      ),
    );
  }
}
