import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Warden Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                child: Text(
                  'Student Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
