import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson_flutter/ScaffoldWidget/lessonScreen.dart';
import 'package:lesson_flutter/ScaffoldWidget/lessonScreen.dart';

class Program extends StatefulWidget {
  const Program({super.key});

  @override
  State<Program> createState() => _ProgramState();
}

int _counter = 0;
final List<String> _pages = ['ទំព័រដើម', 'គណនី'];

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'អរុណសួស្តី';
  } else if (hour < 17) {
    return 'សាយ័នសួស្តី';
  } else {
    return 'រាត្រីសួស្តី';
  }
}

class _ProgramState extends State<Program> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'សៀវភៅចេនឡា',
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white,
                        fontSize: 27,
                      ),
                    ),
                    Text(
                      getGreeting(),
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildFeaturedCard(context),
                    SizedBox(height: 20),
                    Text(
                      'មេរៀនផ្សេងៗ',
                      style: GoogleFonts.kantumruyPro(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 7),
                    _lessonCard('ការអភិវឌ្ឍន៍កម្មវិធី', 'Flutter and Dart.'),
                    _lessonCard(
                      'ការរចនាគេហទំព័រ',
                      ' HTML, CSS, and JavaScript.',
                    ),
                    _lessonCard(
                      'វិទ្យាសាស្ត្រទិន្នន័យ',
                      'Python, R, and machine learning.',
                    ),
                    _lessonCard(
                      'ការគ្រប់គ្រងបណ្ដាញNetworking',
                      'TCP/IP, DNS, and network security.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color(0xFFD65A60),
        unselectedItemColor: Colors.white70,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white, size: 28),
            label: 'ទំព័រដើម',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.menu, color: Colors.white, size: 28),
            label: 'គណនី',
          ),
        ],
        onTap: (index) {
          setState(() {
            _counter = index;
          });
        },
      ),
    );
  }
}

Widget _buildFeaturedCard(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(20.0),
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(5.0),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'កាលបរិច្ឆេទ',
                style: GoogleFonts.kantumruyPro(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                'កំណត់កាលបរិច្ឆេទសម្រាប់ការសិក្សា',
                style: GoogleFonts.kantumruyPro(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFD65A60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Lessonscreen()),
            );
          },

          child: Text(
            'កំណត់',
            style: GoogleFonts.kantumruyPro(
              color: Colors.white,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// lesson Card
Widget _lessonCard(String title, String description) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15.0),
    padding: const EdgeInsets.all(18.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.kantumruyPro(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: GoogleFonts.kantumruyPro(color: Colors.white70, fontSize: 15),
        ),
      ],
    ),
  );
}
