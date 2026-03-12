import 'package:flutter/material.dart';
import 'package:lesson_flutter/ScaffoldWidget/appbar.dart';

class Homework extends StatefulWidget {
  const Homework({super.key});

  @override
  State<Homework> createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        // title: Text("Home Work"),
        actions: [
          Text("Click Next to show "),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAppbar()),
              );
            },
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "កិច្ចការផ្ទះ",
          style: TextStyle(
            fontSize: 24,
            color: Colors.cyan[500],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
