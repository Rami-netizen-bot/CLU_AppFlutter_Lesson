import 'package:flutter/material.dart';

void main(List<String> args) {}

class Dropdownflutter extends StatefulWidget {
  const Dropdownflutter({super.key});

  @override
  State<Dropdownflutter> createState() => _DropdownflutterState();
}

class _DropdownflutterState extends State<Dropdownflutter> {
  final Set<String> selected = {'Flutter', 'Kotlin'};
  bool isExpanded = false;
  final techs = [
    {'name': 'Flutter', 'color': Colors.blue},
    {'name': 'Dart', 'color': Colors.teal},
    {'name': 'Java', 'color': Colors.orange},
    {'name': 'Kotlin', 'color': Colors.purple},
    {'name': 'Swift', 'color': Colors.deepOrange},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Example Dropdown",
          style: TextStyle(color: Colors.black26, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select technology",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...techs.map((t) {
                final name = t['name'] as String;
                final color = t['color'] as Color;
                final isSelected = selected.contains(name);
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withOpacity(0.2),
                    child: Text(name[0], style: TextStyle(color: color)),
                  ),
                  title: Text(name),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.purple)
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                  onTap: () => setState(
                    () =>
                        isSelected ? selected.remove(name) : selected.add(name),
                  ),
                  
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
