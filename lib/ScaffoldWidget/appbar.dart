import 'package:flutter/material.dart';
import 'package:lesson_flutter/ScaffoldWidget/homework.dart';
import 'package:lesson_flutter/main.dart';

void main(List<String> args) {
  runApp(const MyAppbar());
}

class MyAppbar extends StatelessWidget {
  const MyAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: _Myappbar());
  }
}

class _Myappbar extends StatefulWidget {
  const _Myappbar({super.key});

  @override
  State<_Myappbar> createState() => __MyappbarState();
}

class __MyappbarState extends State<_Myappbar> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("App bar homework"),
        content: const Text('success homework'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homework()),
            ),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
        title: Text("Appbar"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.dark_mode, color: Colors.blueGrey),
            onPressed: () {},
          ),
          IconButton(icon: Icon(Icons.notifications_off), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: _showDialog,
          ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  " Pittsburgh is a city in the state of Pennsylvania in the "
                  "United States. It is the county seat of Allegheny County. "
                  "A population of about 302,407 residents live within the city "
                  "limits, making it the 68th-largest city in the U.S.",
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Powerful hunter",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              "https://wallpapers-clan.com/wp-content/uploads/2025/01/black-and-white-zoro-swordfighter-anime-wallpaper-preview.jpg",
            ),
          ),
        ],
      ),
    );
  }
}
