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
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('complaints').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  List<ComplaintCard> messageWidget = [];
                  for (var message in messages) {
                    messageWidget.add(ComplaintCard(
                        description: Text(message['description'])));
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

  ComplaintCard({this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Complaint(
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
        child: Center(child: description),
      ),
    );
  }
}
