import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Chooselag extends StatefulWidget {
  const Chooselag({super.key});

  @override
  State<Chooselag> createState() => _ChooselagState();
}

class _ChooselagState extends State<Chooselag> {
  String selected = 'English';
  final languages = [
    {'name': 'English', 'native': 'Englsih', 'code': 'en'},
    {'name': 'Spanish', 'native': 'Espanol', 'code': 'es'},
    {'name': 'French', 'native': 'Francais', 'code': 'fr'},
    {'name': 'German', 'native': 'Deutsch', 'code': 'de'},
    {'name': 'Italian', 'native': 'Italiano', 'code': 'it'},
  ];

  void _onContinue() {
    final lang = languages.firstWhere((l) => l['name'] == selected);

    print('Selected : ${lang['name']}');
    print('Native : ${lang['native']}');
    print('Code : ${lang['code']}');
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(content: Text('Language : ${lang['name']}(${lang['code']})')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedlang = languages.firstWhere((l) => l['name'] == selected);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Choose Language",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "select your prefferd language",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.language, color: Colors.indigo),
                    const SizedBox(width: 10),
                    Text(
                      'Select ${selectedlang['name']}'
                      '(${selectedlang['native']}'
                      '[${selectedlang['code']}])',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
