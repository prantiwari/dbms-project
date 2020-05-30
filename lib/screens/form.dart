import 'package:dbmsj/screens/studentcomplaints.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:dbmsj/main.dart';

class Forms extends StatefulWidget {
  @override
  _FormsState createState() => _FormsState();
  var selected = "Electrical";
}

class _FormsState extends State<Forms> {
  bool spin = false;
  final _firestore = Firestore.instance;
  var complaintTypes = ['Electrical', 'House-Keeping', 'Mess', 'Miscellaneous'];

  var registrationNo;
  var complaintHeader;
  var description;

  @override
  Widget build(BuildContext context) {
    void writeData() async {
      await _firestore
          .collection(widget.selected)
          .document('Unresolved')
          .collection('Complaints')
          .add(
        {
          'Complaint': complaintHeader,
          'Description': description,
          'Student Reg. No.': Provider.of<User>(context, listen: false).regNo,
          'State': 'Unresolved',
          'Created': FieldValue.serverTimestamp(),
          'Room': Provider.of<User>(context, listen: false).roomNo
        },
      );

      Navigator.pop(context);

      setState(() {
        spin = false;
      });
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spin,
        child: SafeArea(
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
                          hintText: 'Complaint Header'),
                      onChanged: (value) {
                        complaintHeader = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DropdownButton<String>(
                      value: widget.selected,
                      items: complaintTypes.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (changedValue) {
                        setState(() {
                          widget.selected = changedValue;
                        });
                      },
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
                      onChanged: (value) {
                        description = value;
                      },
                    ),
                  ),
                  Center(
                    child: InkWell(
                        child: Hero(
                            tag: "icon",
                            child: Icon(
                              Icons.near_me,
                              size: 50,
                            )),
                        onTap: () {
                          setState(() {
                            spin = true;
                          });
                          writeData();
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
