import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmsj/complaint.dart';

class StudentComplaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<StudentComplaints> {
  var _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    _firestore.collectionGroup("Complaints").snapshots();
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collectionGroup("Complaints").snapshots(),
              /*_firestore
                  .collection('Electrical')
                  .document('Electrical-Complaints')
                  .collection('Unresolved')
                  .snapshots(), */
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  List<ComplaintCard> messageWidget = [];
                  for (var message in messages) {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Complaint(message, "Processing"),
            ));
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
                Text(registrationNumber),
              ],
            ),
          )),
    );
  }
}
