import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_page.dart';

class OTPscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OTPscreen();
  }
}

class _OTPscreen extends State<OTPscreen> {
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
                    child: Text('On Number  : ',
                        style: TextStyle(
                          fontSize: 16,
                        ))),
                SizedBox(height: 20),
              ]),
        ),
      ),
    );
  }
}
