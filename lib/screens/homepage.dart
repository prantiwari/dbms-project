import 'package:dbmsj/screens/form.dart';
import 'package:dbmsj/screens/signin.dart';
import 'package:dbmsj/screens/signup.dart';
import 'package:dbmsj/screens/studentcomplaints.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(width: 200),
          InkWell(
            child: Text(
              "Create Account",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 150),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    },
                    minWidth: 300.0,
                    height: 60.0,
                    child: Text(
                      'Warden Log In',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    elevation: 5.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentComplaints(),
                          ),
                        );
                      },
                      minWidth: 300.0,
                      height: 60.0,
                      child: Text(
                        'Student Log In',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
