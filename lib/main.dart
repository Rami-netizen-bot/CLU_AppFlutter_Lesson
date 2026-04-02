import 'package:flutter/material.dart';
import 'package:lesson_flutter/ScaffoldWidget/SlidingUpPanel.dart';
import 'package:lesson_flutter/ScaffoldWidget/chooselag.dart';
import 'package:lesson_flutter/ScaffoldWidget/detailpage.dart';
import 'package:lesson_flutter/ScaffoldWidget/dropdown2.dart';
import 'package:lesson_flutter/ScaffoldWidget/dropdownflutter.dart';
import 'package:lesson_flutter/ScaffoldWidget/homework.dart';
import 'package:lesson_flutter/ScaffoldWidget/slideable.dart';
import 'package:lesson_flutter/ScaffoldWidget/splashScreen.dart';
import 'package:lesson_flutter/drawerWidget.dart';
import 'package:lesson_flutter/get_oop.dart';
import 'ScaffoldWidget/Listview.dart';
import 'ScaffoldWidget/App_bar.dart';
import 'ScaffoldWidget/bottomapp.dart';
import 'ScaffoldWidget/appbar.dart';
import 'ScaffoldWidget/sliverappbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ScaffoldWidget/choseCategory.dart';
import 'model/lessonItem.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LessonItem> lessons = [
      LessonItem(
        number: 1,
        title: "Listview",
        description: "Display scrollable list of widgets",
        page: const Listview(),
      ),
      LessonItem(
        number: 2,
        title: "App Bar Text Field",
        description: "Search field inside the AppBar",
        page: const textfield(),
      ),
      LessonItem(
        number: 3,
        title: "Bottom App Bar",
        description: "Navigation bar at the bottom",
        page: const bottomapp(),
      ),
      LessonItem(
        number: 4,
        title: "Sliver App Bar",
        description: "Collapsible scrollable app bar",
        page: const Sliverappbar(),
      ),
      LessonItem(
        number: 5,
        title: "Slideable Button",
        description: "Swipe actions on list items",
        page: const Myslideable(),
      ),
      LessonItem(
        number: 6,
        title: "Sliding Up Panel",
        description: "Bottom sheet panel overlay",
        page: const Slidinguppanel(),
      ),
      LessonItem(
        number: 7,
        title: "Detail Page Card",
        description: "Navigate to a card detail view",
        page: const Detailpage(),
      ),
      LessonItem(
        number: 8,
        title: "Dropdown",
        description: "Basic dropdown selector widget",
        page: const Dropdownflutter(),
      ),
      LessonItem(
        number: 9,
        title: "Dropdown 2",
        description: "Advanced dropdown example",
        page: const Dropdown2(),
      ),
      LessonItem(
        number: 10,
        title: "Choose Language",
        description: "Localization language picker",
        page: const Chooselag(),
      ),
      LessonItem(
        number: 11,
        title: "Homework",
        description: "Practice exercise screen",
        page: const Homework(),
      ),
      LessonItem(
        number: 12,
        title: "Drawer Widget",
        description: "Side navigation drawer demo",
        page: const DrawerWidgetDemo(),
      ),
      LessonItem(
        number: 13,
        title: "Auth App",
        description: "Login and authentication flow",
        page: const AuthApp(),
      ),
      LessonItem(
        number: 13,
        title: "Catagary",
        description: "Chose option Categary",
        page: const DropdownControllerApp(),
      ),
      LessonItem(
        number: 14,
        title: "Splash Screen",
        description: "Main App Book Page",
        page: const SplashScreen(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "កិច្ចការសម្រាប់ Mobile Programing",
          style: GoogleFonts.kantumruyPro(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: lessons.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final lesson = lessons[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade50,
              child: Text(
                "${lesson.number}",
                style: TextStyle(
                  color: Colors.indigo.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            title: Text(
              lesson.title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              lesson.description,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => lesson.page),
              );
            },
          );
        },
      ),
    );
  }
}
