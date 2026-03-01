import 'package:flutter/material.dart';

class textfield extends StatefulWidget {
  const textfield({super.key});

  @override
  State<textfield> createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("App Bar Text Field")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white.withOpacity(0.5),
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelStyle: TextStyle(fontSize: 15, color: Colors.black),
              hintText: "Enter your email",
              hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
              labelText: "Email",
              border: InputBorder.none,
            ),
            obscureText: false,
          ),
        ),
      ),
    );
  }
}
