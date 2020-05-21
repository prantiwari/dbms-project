import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum state { Unresolved, Resolved, Processing }

class Complaint extends StatelessWidget {
  Text description;
  state status;
  Complaint({this.description, this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(8),
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF1D1E33),
        ),
        child: Center(child: description),
      ),
    );
  }
}
