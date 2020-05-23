import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum state { Unresolved, Resolved, Processing }

class Complaint extends StatefulWidget {
  var message;
  String description;
  String complaintHeader;
  String registrationNumber;
  String documentId;
  Complaint(var message) {
    this.message = message;
    this.description = message['Description'];
    this.registrationNumber = message['Student Reg. No.'];
    this.complaintHeader = message['Complaint'];
    this.documentId = message.documentID;
  }

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  var _firestore = Firestore.instance;
  String newValue = 'Processing';
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
                Text("Registration Number: " + widget.registrationNumber),
                SizedBox(height: 10),
                Text("Complaint Header: " + widget.complaintHeader),
                SizedBox(height: 20),
                Text("Description: " + widget.description),
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
                      _firestore
                          .collection('Electrical')
                          .document('Electrical-Complaints')
                          .collection('Processing')
                          .document(widget.message.documentID)
                          .delete();

                      _firestore
                          .collection('Electrical')
                          .document('Electrical-Complaints')
                          .collection('Resolved')
                          .add(widget.message.data);

                      Navigator.pop(context);
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
