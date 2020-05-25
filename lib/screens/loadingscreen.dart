import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(height: 150),
          Hero(
              tag: "icon",
              child: Icon(
                Icons.near_me,
                size: 100,
                color: Colors.white,
              )),
          SpinKitChasingDots(color: Colors.white, size: 30.0),
        ],
      )),
    );
  }
}
