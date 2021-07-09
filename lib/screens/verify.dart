import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/register.dart';

class VerifyScreen extends StatefulWidget {
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = auth.currentUser!;
    user.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {});
    checkEmailVerified();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Text("An email has been sent to ${user.email}, please verify"),
      Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: ElevatedButton(
              child: Text("Verified"),
              onPressed: () {
                if (user.emailVerified) {
                  timer.cancel();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Mainpage()));
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? currentUser = auth.currentUser;
                  var userUid = currentUser!.uid;
                  Register.userUid = userUid;
                  var telegramId = Register.telegramId;

                  var collection =
                      FirebaseFirestore.instance.collection('users');
                  collection
                      .doc('$userUid') // <-- Document ID
                      .set({
                        'email Id': user.email,
                        'telegram id': telegramId
                      }) // <-- Your data
                      .then((_) => print('Added: $userUid'))
                      .catchError((error) => print('Add failed: $error'));
                }
              }))
    ])));
  }

  Future<void> checkEmailVerified() async {
    user = auth.currentUser!;
    //await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Mainpage()));
    }
  }
}
