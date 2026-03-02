import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lesson_flutter/ScaffoldWidget/Listview.dart';

class Myslideable extends StatefulWidget {
  const Myslideable({super.key});
  @override
  State<Myslideable> createState() => _MyslideableState();
}

class _MyslideableState extends State<Myslideable> {
  final List<Map<String, String>> items = [
    {"name": "Ramy", "role": "Mobile Developer"},
    {"name": "Sophea", "role": "Web Developer"},
    {"name": "Dara", "role": "UI/UX Designer"},
    {"name": "Mony", "role": "Backend Developer"},
    {"name": "Chenda", "role": "Data Analyst"},
    {"name": "Messi", "role": "Dev ops"},
    {"name": "Ronaldo", "role": "Data Science"},
    {"name": "Neymar", "role": "AI Developer"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // ← was blending with gradient
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ), // ← white to be visible
        ),
        title: const Text(
          "Slideable Flutter",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() => items.removeAt(index));
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: "Delete",
                ),
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.edit,
                  label: "Edit",
                ),
              ],
            ),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: "Share",
                ),
              ],
            ),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Colors.pink, Colors.cyan],
                ),
              ),
              child: ListTile(
                title: Text(items[index]["name"]!),
                subtitle: Text(items[index]["role"]!),
                leading: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
