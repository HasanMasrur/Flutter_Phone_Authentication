import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../auth_page.dart';
import '../homepage.dart';

class OTPscreen extends StatefulWidget {
  final number;
  OTPscreen(this.number);
  @override
  State<StatefulWidget> createState() {
    return _OTPscreen();
  }
}

class _OTPscreen extends State<OTPscreen> {
  @override
  void initState() {
    _submit();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String verificationCode;
  String smsCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    // color: const Color.fromRGBO(43, 46, 66, 1),
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
      //  color: Colors.black,
    ),
  );
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 990,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5DC),
        ),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(
                    left: 20,
                    top: 60,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 30,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Authpage()),
                          (route) => false);
                    },
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      left: 30,
                      top: 40,
                    ),
                    child: Text('Verification',
                        style: TextStyle(fontSize: 18, color: Colors.black))),
                SizedBox(height: 32),
                Container(
                    margin: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Text('We sent you an SMS code ',
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.only(
                      left: 30,
                    ),
                    child: Text('On Number  : + ${widget.number}',
                        style: TextStyle(
                          fontSize: 16,
                        ))),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle: const TextStyle(
                        fontSize: 25.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: verificationCode, smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                                (route) => false);
                          } else {
                            print('invalid code');
                          }
                        });
                      } catch (e) {
                        print('invalid code');
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Invalid Code '),
                                content: Text('Try again'),
                                actions: [
                                  RaisedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Okay')),
                                ],
                              );
                            });
                      }
                    },
                  ),
                ),
              ]),
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
      //_smscode(context).then((value) => print('success'));
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verId) {
      this.verificationCode = verId;
    };
    _auth.verifyPhoneNumber(
      phoneNumber: widget.number,
      verificationCompleted: verificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }
}
