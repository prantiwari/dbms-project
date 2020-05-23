import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum state { Unresolved, Resolved, Processing }

class Complaint extends StatefulWidget {
  Text description;
  Text complaintHeader;
  Text registrationNumber;
  String documentId;
  Complaint(
      {this.description,
      this.complaintHeader,
      this.registrationNumber,
      this.documentId});

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  String newValue = 'Unresolved';
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
                Text("Registration Number: " + widget.registrationNumber.data),
                SizedBox(height: 10),
                Text("Complaint Header: " + widget.complaintHeader.data),
                SizedBox(height: 20),
                Text("Description: " + widget.description.data),
                SizedBox(height: 20),
                Container(
                  color: Colors.white,
                  child: new DropdownButton<String>(
                    iconDisabledColor: Colors.white,
                    value: newValue,
                    items: <String>['Unresolved', 'Processing', 'Resolved']
                        .map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (changedValue) {
                      setState(() {
                        newValue = changedValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
