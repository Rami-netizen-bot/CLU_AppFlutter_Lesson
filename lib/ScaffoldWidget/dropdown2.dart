import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: Dropdown2()),
  );
}

class Dropdown2 extends StatefulWidget {
  const Dropdown2({super.key});

  @override
  State<Dropdown2> createState() => _DropdownflutterState();
}

class _DropdownflutterState extends State<Dropdown2> {
  final Set<String> selected = {'Flutter', 'Kotlin'};
  bool isExpanded = false; // Controls the dropdown visibility

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text("Dropdown Example")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  // --- The Dropdown Header ---
                  ListTile(
                    title: const Text(
                      "Select Technologies",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("${selected.length} items selected"),
                    trailing: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.purple,
                    ),
                    onTap: () => setState(() => isExpanded = !isExpanded),
                  ),

                  // --- The Dropdown Body (Conditional) ---
                  if (isExpanded) ...[
                    const Divider(height: 1),
                    ...techs.map((t) {
                      final name = t['name'] as String;
                      final color = t['color'] as Color;
                      final isSelected = selected.contains(name);

                      return ListTile(
                        dense: true, // Makes the items more compact
                        leading: CircleAvatar(
                          radius: 15,
                          backgroundColor: color.withOpacity(0.1),
                          child: Text(
                            name[0],
                            style: TextStyle(color: color, fontSize: 12),
                          ),
                        ),
                        title: Text(name),
                        trailing: Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: isSelected ? Colors.purple : Colors.grey,
                        ),
                        onTap: () {
                          setState(() {
                            isSelected
                                ? selected.remove(name)
                                : selected.add(name);
                          });
                        },
                      );
                    }),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
