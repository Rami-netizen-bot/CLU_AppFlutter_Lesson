import 'package:flutter/material.dart';
import 'ScaffoldWidget/Listview.dart';
import 'ScaffoldWidget/App_bar.dart';
import 'ScaffoldWidget/bottomapp.dart'; // ← ADD THIS
import 'ScaffoldWidget/appbar.dart'; // ← ADD THIS

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text("Flutter Scaffold Widget"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Listview()),
                );
              },
              child: const Text("Go to Listview"),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const textfield()),
                );
              },
              child: const Text("Go to App Bar Text Field"),
            ),
                SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const bottomapp()),
                );
              },
              child: Text("Go to bottom app"),
            ),
          ],
        ),
      ),
    );
  }
}
