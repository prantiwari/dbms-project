import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  var _firestore = Firestore.instance;
  String emailId;
  String password;
  String room;
  String regNo;
  bool spin = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: spin,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign-Up"),
        ),
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
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'youremailid@example.com'),
                      onChanged: (value) {
                        emailId = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Password'),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Registration Number'),
                      onChanged: (value) {
                        regNo = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Room Number'),
                      onChanged: (value) {
                        room = value;
                      },
                    ),
                  ),
                  Center(
                    child: FlatButton(
                      child: Icon(Icons.near_me, size: 50),
                      onPressed: () async {
                        try {
                          setState(() {
                            spin = true;
                          });
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: emailId, password: password);
                          _firestore.collection('Students').add({
                            'emailID': emailId,
                            'regNo': regNo,
                            'Room': room
                          });
                          setState(() {
                            spin = false;
                          });
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
