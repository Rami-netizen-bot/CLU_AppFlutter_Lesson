import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson_flutter/ScaffoldWidget/App_bar.dart';
import 'package:lesson_flutter/ScaffoldWidget/choseCategory.dart';

class Lessonscreen extends StatefulWidget {
  const Lessonscreen({super.key});

  @override
  State<Lessonscreen> createState() => _LessonscreenState();
}

class _LessonscreenState extends State<Lessonscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Color(0xFFD65A60),
                          size: 30,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'ត្រលប់ក្រោយ',
                          style: GoogleFonts.kantumruyPro(
                            color: Color(0xFFD65A60),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showExampleDialog(context);
                    },
                    icon: Icon(Icons.add, color: Color(0xFFD65A60), size: 28),
                  ),
                ],
              ),
              Divider(
                color: const Color.fromARGB(255, 225, 159, 159),
                thickness: 0,
                height: 1,
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ជួយយើងកំណត់កាលបរិច្ឆេទប្រឡង',
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'អ្នកនឹងអាចផ្លាស់ប្តូរកាលបរិច្ឆេទប្រឡងនៅពេលក្រោយបាន',
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white,
                        fontSize: 17,
                      ),
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

void _showExampleDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Color(0xFF1E1E1E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ផ្លាស់ប្តូរកាលបរិច្ឆេទប្រឡង?',
                style: GoogleFonts.kantumruyPro(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'ប្រភេទនៃការប្រលង',
                  hintStyle: GoogleFonts.kantumruyPro(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Color(0xFF2D2D2D),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ស្ថានភាព',
                style: GoogleFonts.kantumruyPro(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 10),

              Text(
                'កាលបរិច្ឆេទប្រឡង',
                style: GoogleFonts.kantumruyPro(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    textTheme: CupertinoTextThemeData(
                      pickerTextStyle: TextStyle(
                        color: Color.fromARGB(255, 28, 25, 25),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildSimplePicker(List.generate(31, (i) => '${i + 1}')),
                      _buildSimplePicker([
                        'មករា',
                        'កុម្ភៈ',
                        'មីនា',
                        'មេសា',
                        'ឧសភា',
                        'មិថុនា',
                        'កក្កដា',
                        'សីហា',
                        'កញ្ញា',
                        'តុលា',
                        'វិច្ឆិកា',
                        'ធ្នូ',
                      ], isKhmer: true),
                      _buildSimplePicker(
                        List.generate(10, (i) => '${2025 + i}'),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'បោះបង់',
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'អនុវត្ត',
                      style: GoogleFonts.kantumruyPro(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildSimplePicker(List<String> items, {bool isKhmer = false}) {
  return Expanded(
    child: CupertinoPicker(
      itemExtent: 32.0,
      selectionOverlay: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onSelectedItemChanged: (int index) {},
      children: items.map((item) {
        return Center(
          child: Text(
            item,
            style: GoogleFonts.kantumruyPro(color: Colors.white, fontSize: 16),
          ),
        );
      }).toList(),
    ),
  );
}
