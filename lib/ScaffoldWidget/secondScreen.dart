import 'package:flutter/material.dart';
import 'package:lesson_flutter/ScaffoldWidget/Program.dart';
import 'package:lesson_flutter/ScaffoldWidget/homework.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _SecondscreenState();
}

class _SecondscreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Icon(Icons.notifications, color: Colors.white, size: 100),
              SizedBox(height: 40),
              Text(
                'ការជូនដំណឹងទាំងអស់',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                'អនុញ្ញាតឱ្យយើងជូនដំណឹងដល់អ្នកនៅពេលមាន\nព័ត៌មានទាក់ទងនឹងកម្មវិធី',
                textAlign: TextAlign.center,
                style: GoogleFonts.kantumruyPro(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Program()),
                    );
                  },
                  child: Text(
                    'អនុញ្ញាត',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
