import 'package:dbmsj/screens/complaints.dart';
import 'package:dbmsj/screens/loadingscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String emailId;
  String password;

  @override
  Widget build(BuildContext context) {
    void verify() async {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(
            email: emailId, password: password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Complaints()));
      } catch (e) {
        print(e);
      }
    }

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
                      verify();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoadingScreen(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
