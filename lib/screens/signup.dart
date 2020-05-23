import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    String emailid;
    String password;
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
                      emailid = value;
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
                  child: FlatButton(
                    child: Icon(Icons.near_me, size: 50),
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: emailid, password: password);
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
    );
    ;
  }
}
