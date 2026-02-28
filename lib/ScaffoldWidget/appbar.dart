import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyAppbar());
}

class MyAppbar extends StatelessWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _Myappbar(),
    );
  }
}

class _Myappbar extends StatefulWidget {
  const _Myappbar({super.key});

  @override
  State<_Myappbar> createState() => __MyappbarState();
}

class __MyappbarState extends State<_Myappbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        leading: IconButton(icon: Icon(Icons.home), onPressed: () {
          print("Home button pressed");
        }),
        title: Text("Appbar"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera), onPressed: () {}),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            child: Text(
              "Bottom Appbar",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
