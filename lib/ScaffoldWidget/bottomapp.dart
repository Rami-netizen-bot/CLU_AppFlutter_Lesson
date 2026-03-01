import 'package:flutter/material.dart';

class bottomapp extends StatelessWidget {
  // ← lowercase b to match main.dart
  const bottomapp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 160, 232),
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("CLU Flutter"),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: const Icon(Icons.camera), onPressed: () {}),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Chenla University",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
      body: const Center(
        // ← ADD a body, empty Scaffold causes issues
        child: Text("Bottom App Bar Page"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: const Icon(Icons.home), onPressed: () {}),
            IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: const Icon(Icons.camera), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
