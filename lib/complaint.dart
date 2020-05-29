import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint extends StatefulWidget {
  var message;
  String description;
  String complaintHeader;
  String registrationNumber;
  String documentId;
  String state;
  String complaintType;
  String userType;
  Complaint(var message, String complaintType, String userType) {
    this.message = message;
    this.description = message['Description'];
    this.registrationNumber = message['Student Reg. No.'];
    this.complaintHeader = message['Complaint'];
    this.documentId = message.documentID;
    this.state = message['State'];
    this.complaintType = complaintType;
    this.userType = userType;
  }

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  var _firestore = Firestore.instance;

  Widget getWidget(String userType) {
    if (userType == "Warden") {
      return Container(
        color: Colors.white,
        child: new DropdownButton<String>(
          iconDisabledColor: Colors.white,
          value: widget.state,
          items: <String>['Unresolved', 'Processing', 'Resolved']
              .map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (changedValue) {
            if (changedValue != widget.state)
              _firestore
                  .collection(widget.complaintType)
                  .document(widget.state)
                  .collection('Complaints')
                  .document(widget.message.documentID)
                  .delete();

            _firestore
                .collection(widget.complaintType)
                .document(changedValue)
                .collection('Complaints')
                .add({
              "Complaint": widget.complaintHeader,
              "State": changedValue,
              "Description": widget.description,
              "Student Reg. No.": widget.registrationNumber,
              "Created": widget.message['Created']
            });

            Navigator.pop(context);
          },
        ),
      );
    } else {
      String state = widget.state;
      return Text(" State: $state");
    }
  }

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Registration Number: " + widget.registrationNumber),
                SizedBox(height: 10),
                Text("Complaint Header: " + widget.complaintHeader),
                SizedBox(height: 20),
                Text("Description: " + widget.description),
                SizedBox(height: 20),
                // Text("Created: " +
                //     widget.message['Created'].toDate().toString()),
                SizedBox(height: 20),
                getWidget(widget.userType),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
