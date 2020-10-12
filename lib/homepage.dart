import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String uid;
  void initState() {
    this.uid = "";
    final user = FirebaseAuth.instance.currentUser;

    setState(() {
      this.uid = user.uid;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Text("Welcome to HomePage \n $uid"),
      ),
    );
  }
}
