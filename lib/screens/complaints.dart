import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dbmsj/complaint.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Complaints extends StatefulWidget {
  var selectedCat = "House-Keeping";
  var selectedState = "Processing";

  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  var complaintState = ["Processing", "Resolved", "Unresolved"];
  var complaintTypes = ['Electrical', 'House-Keeping', 'Mess', 'Miscellaneous'];
  final _firestore = Firestore.instance;
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
          //Icon(Icons.power_settings_new),

          SizedBox(width: 30),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: new DropdownButton<String>(
              iconDisabledColor: Colors.white,
              value: widget.selectedCat,
              items: complaintTypes.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (changedValue) {
                setState(() {
                  widget.selectedCat = changedValue;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            color: Colors.white,
            child: new DropdownButton<String>(
              iconDisabledColor: Colors.white,
              value: widget.selectedState,
              items: complaintState.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (changedValue) {
                setState(() {
                  widget.selectedState = changedValue;
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
                  .collection(widget.selectedCat)
                  .document(widget.selectedState)
                  .collection('Complaints')
                  .snapshots(),
              //stream: _firestore.collection('complaints').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var messages = snapshot.data.documents;
                  List<ComplaintCard> messageWidget = [];
                  for (var message in messages) {
                    messageWidget.add(
                      ComplaintCard(message, widget.selectedCat),
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
  String complaintType;
  String description;
  String registrationNumber;
  String complaintHeader;
  String documentId;
  var message;

  ComplaintCard(var message, String complaintType) {
    this.message = message;
    this.description = message['Description'];
    this.registrationNumber = message['Student Reg. No.'];
    this.complaintHeader = message['Complaint'];
    this.documentId = message.documentID;
    this.complaintType = complaintType;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Complaint(message, complaintType, "Warden"),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.all(8),
          height: 120,
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
                Text("Registration No: " + registrationNumber),
                Text('Room No:' + message['Room']),
              ],
            ),
          )),
    );
  }
}
