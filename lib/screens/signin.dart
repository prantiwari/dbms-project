import 'package:dbmsj/screens/complaints.dart';
import 'package:dbmsj/screens/loadingscreen.dart';
import 'package:dbmsj/screens/studentcomplaints.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignIn extends StatefulWidget {
  String userType;
  SignIn(String userType) {
    this.userType = userType;
  }

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;

  String emailId;
  String password;
  bool spin = false;

  @override
  Widget build(BuildContext context) {
    void verify() async {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(
            email: emailId, password: password);
        if (widget.userType == "Warden")
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Complaints()));
        else
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StudentComplaints()));
        setState(() {
          spin = false;
        });
      } catch (e) {
        print(e);
      }
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
                  Center(
                    child: InkWell(
                      child: Hero(
                        tag: "icon",
                        child: Icon(Icons.near_me, size: 50),
                      ),
                      onTap: () async {
                        setState(() {
                          spin = true;
                        });

                        verify();
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoadingScreen(),
                          ),
                        );*/
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
