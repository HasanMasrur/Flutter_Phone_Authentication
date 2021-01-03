import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_Phone_authentication/page/otpscreen.dart';

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
  showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text('Please Confirm your phone number :  ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        content: Text(number),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("Edit")),
          FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OTPscreen(number)));
              },
              child: Text('Okay')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 270,
              color: Color(0xFFF5F5DC),
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
                        color: Color(0xFFF5F5DC),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 140,
                      top: 120,
                      child: Container(
                        height: 120,
                        width: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRU3Y1wumB36baqkiReVPMS8qyGE0PMe5O-wg&usqp=CAU',
                                ),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue,
                                  blurRadius: 4,
                                  spreadRadius: 5,
                                  offset: Offset(0, 0))
                            ]),
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
                    maxLength: 11,
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
                      number = '+88' + vlaue;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                      child: Text('SignIn'),
                      color: Colors.red,
                      onPressed: () {
                        if (number != null && number != "+88") {
                          showdialog();
                        } else {
                          return;
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
