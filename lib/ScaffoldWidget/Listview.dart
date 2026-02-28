import 'package:flutter/material.dart';

void main(List<String> args) {}

class Listview extends StatefulWidget {
  const Listview({super.key});

  @override
  State<Listview> createState() => _ListviewState();
}

class _ListviewState extends State<Listview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listview", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text("Sunny Day"),
            subtitle: Text("A bright and cheerful day"),
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text("Cloudy Day"),
            subtitle: Text("A day filled with clouds"),
          ),
          ListTile(
            leading: Icon(Icons.cloudy_snowing),
            title: Text("Rainy Day"),
            subtitle: Text("A day with rain showers"),
          ),
          ListTile(
            leading: Icon(Icons.thunderstorm),
            title: Text("Thunderstorm"),
            subtitle: Text("A day with thunderstorms"),
          ),
        ],
      ),
    );
  }
}


