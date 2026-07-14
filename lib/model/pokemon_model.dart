import 'package:flutter/material.dart';

class Pokemon {
  String name;
  String imageUrl;

  Pokemon({required this.name, required this.imageUrl});
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    String url = json['url'];
    List<String> segments = url.split('/');
    String id = segments[segments.length - 2];
    return Pokemon(
      name: json['name'][0].toUpperCase() + json['name'].substring(1),
      imageUrl:
          "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png",
    );
  }
}
