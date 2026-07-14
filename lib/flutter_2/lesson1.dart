import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // CupterinoApp
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Chenla University'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final icInstagram = "assets/icons/ic_instagram.png";

  Future getSomeData() {
    return Future.delayed(Duration(seconds: 5));
  }

  // MMDDYYYY = 07022026
  // DDMMYYYY = 02072026
  // YYYYDDMM = 20260207

  Future<DateTime> getDateTime(DateTime dateTime) async {
    await Future.delayed(Duration(seconds: 5));
    return dateTime;
  }

  String formattedDateTime(DateTime dateTime) {
    DateTime parsedDateTime = DateTime.parse(dateTime.toString());
    String format1 = DateFormat('yyyy-MM-dd').format(dateTime);
    String format2 = DateFormat('dd-MMMM-yyyy').format(dateTime);
    String format3 = DateFormat('dd,MMMM,yyyy').format(dateTime);
    String format4 = DateFormat('EEEE, MMMM dd, yyyy').format(dateTime);
    return format4;

    // return "${parsedDateTime.day}/${parsedDateTime.month}/${parsedDateTime.year}";
  }

  @override
  void initState() async {
    DateTime myNewDate = await getDateTime(DateTime.now());
    print(('What time is it?$myNewDate'));

    getDateTime(DateTime.now()).then((value) {
      print(('What time is it?$value'));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getDateTime(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null) {
            return Center(child: Text("There is no data!"));
          }
          return Center(
            child: Text(
              formattedDateTime(snapshot.data ?? DateTime.now()),
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
