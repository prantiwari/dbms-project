import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmsj/complaint.dart';

class Complaints extends StatefulWidget {
  var complaintCategory = ["Processing", "Resolved", "Unresolved"];
  int i;
  Complaints() {
    i = 0;
  }
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    var messages = (_firestore.collection('compaints').getDocuments());

    return Scaffold(
      appBar: AppBar(
        title: Text("Compaints"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: new DropdownButton<String>(
              iconDisabledColor: Colors.white,
              value: 'Electrical',
              items: <String>[
                'Electrical',
                'House-Keeping',
                'Mess',
                'Miscellaneous'
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (changedValue) {
                setState(() {});
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: new DropdownButton<String>(
              iconDisabledColor: Colors.white,
              value: 'Unresolved',
              items: <String>['Resolved', 'Processing', 'Unresolved']
                  .map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (changedValue) {
                setState(() {
                  widget.i++;
                });
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('Electrical')
                  .document('Electrical-Complaints')
                  .collection(widget.complaintCategory[widget.i])
                  .snapshots(),
              //stream: _firestore.collection('complaints').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  List<ComplaintCard> messageWidget = [];
                  for (var message in messages) {
                    messageWidget.add(
                      ComplaintCard(message),
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
              builder: (context) => Complaint(message),
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
