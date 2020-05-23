import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum state { Unresolved, Resolved, Processing }

class Complaint extends StatelessWidget {
  Text description;
  Text complaintHeader;
  Text registrationNumber;
  Complaint({this.description, this.complaintHeader, this.registrationNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(8),
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF1D1E33),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Registration Number: " + registrationNumber.data),
                SizedBox(height: 10),
                Text("Complaint Header: " + complaintHeader.data),
                SizedBox(height: 20),
                Text("Description: " + description.data)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
