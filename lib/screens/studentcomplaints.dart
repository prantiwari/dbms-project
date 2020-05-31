import 'package:dbmsj/screens/form.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmsj/complaint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:dbmsj/main.dart';

class StudentComplaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<StudentComplaints> {
  var _firestore = Firestore.instance;
  var _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return InkWell(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Log Out",
                      style: TextStyle(fontSize: 15),
                    ),
                    Icon(Icons.power_settings_new)
                  ],
                ),
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).accentColor,
                      content: Text(
                        "Exit?",
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: Duration(seconds: 4),
                      action: SnackBarAction(
                        label: "Yes",
                        textColor: Colors.white,
                        onPressed: () {
                          _auth.signOut();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(width: 250),
          InkWell(
            child: Hero(
              tag: "icon",
              child: Icon(Icons.near_me, size: 40),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Forms(),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collectionGroup('Complaints')
                  .orderBy('Created', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  List<ComplaintCard> messageWidget = [];
                  for (var message in messages) {
                    if (message['Student Reg. No.'] ==
                        Provider.of<User>(context, listen: false).regNo)
                      messageWidget.add(ComplaintCard(message));
                  }
                  return ListView(
                      padding: EdgeInsets.all(8), children: messageWidget);
                }
                return Column();
              }),
        ),
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  String description;
  String registrationNumber;
  String complaintHeader;
  String documentId;
  var message;

  ComplaintCard(var message) {
    this.message = message;
    this.description = message['Description'];
    this.registrationNumber = message['Student Reg. No.'];
    this.complaintHeader = message['Complaint'];
    this.documentId = message.documentID;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Complaint(message, "Complaint", "Student")));
      },
      child: Container(
          margin: EdgeInsets.all(8),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFF1D1E33),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text(complaintHeader),
                SizedBox(height: 20),
                Text(registrationNumber),
              ],
            ),
          )),
    );
  }
}
