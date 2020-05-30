import 'package:dbmsj/screens/homepage.dart';
import 'package:dbmsj/screens/signup.dart';
import 'package:dbmsj/screens/studentcomplaints.dart';
import 'package:flutter/material.dart';
import 'package:dbmsj/screens/signin.dart';
import 'package:dbmsj/screens/complaints.dart';
import 'package:dbmsj/screens/form.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Provider<User>(
      create: (_) => User(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF0A0E21),
          accentColor: Colors.purple,
          scaffoldBackgroundColor: Color(0xFF0A0E21),
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.white),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}

class User extends ChangeNotifier {
  String roomNo;
  String regNo;

  setValues(String roomNo, String regNo) {
    this.roomNo = roomNo;
    this.regNo = regNo;
    notifyListeners();
  }
}
