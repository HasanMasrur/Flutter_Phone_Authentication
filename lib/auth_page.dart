import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Authpage();
  }
}

class _Authpage extends State<Authpage> {
  String number;
  String verificationCode;
  String smsCode;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 270,
              color: Colors.white,
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 3,
                            offset: Offset(0, 0),
                            color: Colors.blue,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 140,
                      top: 120,
                      child: Container(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
                          BoxShadow(
                              color: Colors.blue,
                              blurRadius: 4,
                              spreadRadius: 5,
                              offset: Offset(0, 0))
                        ]),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 70,
                          child: ClipOval(
                            child: Text('hasan'),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 150,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 40, right: 30, top: 20),
              child: Column(
                children: [
                  TextFormField(
                    //  keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.call,
                        color: Colors.red,
                      ),
                      prefixStyle: TextStyle(color: Colors.red, fontSize: 25),
                      focusColor: Colors.black,
                      fillColor: Colors.red,
                    ),
                    onChanged: (vlaue) {
                      number = '+88' + vlaue;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      child: Text('SignIn'),
                      color: Colors.red,
                      onPressed: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
