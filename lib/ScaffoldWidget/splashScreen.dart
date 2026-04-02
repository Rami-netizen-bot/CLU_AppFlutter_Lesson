import 'package:flutter/material.dart';
import 'package:lesson_flutter/ScaffoldWidget/appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lesson_flutter/ScaffoldWidget/secondScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  void _onLanguageSelected(BuildContext context, String language) {
    // Navigate to next screen based on selected language
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Selected: $language')));
  }

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Column(
          children: [
            // Your leading/back icons and content go here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                // IconButton(
                //   icon: Icon(Icons.arrow_forward, color: Colors.white),
                //   onPressed: () {},
                // ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Pushes content towards the center
                    const Icon(Icons.language, color: Colors.white, size: 100),
                    const SizedBox(height: 20), // Space between icon and text
                    const Text(
                      'Program of Study',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Welcome to the Mobile Programming Course! Please select your preferred language to continue.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(width: double.infinity, height: 55),
                    SizedBox(
                      width: double
                          .infinity, // This makes the button stretch full width
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFD65A60,
                          ), // The pinkish-red color from your image
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            // Smooth rounded corners
                          ),
                          elevation: 0, // Keeps it flat like the design
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'ចូលទៅកាន់កម្មវិធី',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // Space between buttons

                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: TextButton(
                        // Using TextButton for the transparent look
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyAppbar(),
                            ),
                          );
                        },
                        child: Text(
                          '',
                          style: GoogleFonts.kantumruyPro(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
