import 'package:dbmsj/screens/homepage.dart';
import 'package:dbmsj/screens/signup.dart';
import 'package:dbmsj/screens/studentcomplaints.dart';
import 'package:flutter/material.dart';
import 'package:dbmsj/screens/signin.dart';
import 'package:dbmsj/screens/complaints.dart';
import 'package:dbmsj/screens/form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF0A0E21),
        accentColor: Colors.purple,
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}
