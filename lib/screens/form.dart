import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Forms extends StatelessWidget {
  final _firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    var desc;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 100, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Registration No.'),
                    onChanged: (value) {
                      desc = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Room No.'),
                    onChanged: (value) {
                      desc = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new DropdownButton<String>(
                    value: 'Complaint Type',
                    items: <String>[
                      'A',
                      'B',
                      'C',
                      'D',
                      'Room no',
                      'Complaint Type'
                    ].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  height: 5 * 24.0,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Complaint Description",
                    ),
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Icon(Icons.near_me, size: 50),
                    onPressed: () {
                      _firestore
                          .collection('complaints')
                          .add({'description': desc});
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
