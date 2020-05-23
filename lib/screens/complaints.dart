import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmsj/complaint.dart';

class Complaints extends StatefulWidget {
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    var messages = (_firestore.collection('compaints').getDocuments());

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('Electrical')
                  .document('Electrical-Complaints')
                  .collection('Processing')
                  .snapshots(),
              //stream: _firestore.collection('complaints').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  List<ComplaintCard> messageWidget = [];
                  for (var message in messages) {
                    messageWidget.add(
                      ComplaintCard(
                        description: Text(message['Description']),
                        registrationNumber: Text(message['Student Reg. No.']),
                        complaintHeader: Text(message['Complaint']),
                      ),
                    );
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
  final Text description;
  final Text registrationNumber;
  final Text complaintHeader;

  ComplaintCard(
      {this.description, this.registrationNumber, this.complaintHeader});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Complaint(
                registrationNumber: registrationNumber,
                complaintHeader: complaintHeader,
                description: description,
              ),
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
                complaintHeader,
                registrationNumber,
              ],
            ),
          )),
    );
  }
}
