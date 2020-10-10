import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Authpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Authpage();
  }
}

class _Authpage extends State<Authpage> {
  String number;
  String verificationCode;
  String smscode;
  @override
  Widget build(BuildContext context) {
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
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              padding: EdgeInsets.only(left: 40, right: 30, top: 20),
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
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
                      number = vlaue;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      child: Text('SignIn'),
                      color: Colors.red,
                      onPressed: () {
                        _submit();
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) {
      setState(() {
        print("verification");
        print(credential);
      });
    };
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException exception) {
      print('${exception.message}');
    };
    final PhoneCodeSent phoneCodeSent =
        (String verId, [int forceResendingToken]) {
      this.verificationCode = verId;
      _smscode(context).then((value) => print('success'));
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verId) {
      this.verificationCode = verId;
    };

    _auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: verificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  Future<void> _smscode(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter code'),
            content: TextField(
              onChanged: (value) {
                smscode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10),
            actions: [
              FlatButton(onPressed: () {}, child: Text('verify')),
            ],
          );
        });
  }
}
