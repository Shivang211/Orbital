import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/CreatenewPost.dart';
import 'package:kiraay/screens/Meetnewpeople.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/ResultsToLetOut.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/searchPage.dart';
import 'RentingNewPost.dart';
import 'Results.dart';
import 'package:animated_background/animated_background.dart';
import 'package:simple_animations/simple_animations.dart';

class LendorRent extends StatefulWidget {
  @override
  _LendorRentState createState() => _LendorRentState();
  static var lentOrRent;
}

class _LendorRentState extends State<LendorRent> {
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  Icon _searchIcon = Icon(Icons.search);

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Create New Post",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, foreground: Paint()..shader = linearGradient),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Container(
                  height: 34,
                  width: 30,
                  child: RawMaterialButton(
                    elevation: 5.0,
                    shape: CircleBorder(),
                    fillColor: Colors.black,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CloudFirestoreSearch()),
                      );
                    },
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 34.0,
                    ),
                    constraints: BoxConstraints.tightFor(
                      width: 50.0,
                      height: 56.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: IconButton(
                icon: Icon(Icons.home, size: 33),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Mainpage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(key: _formKey, children: [
        Positioned.fill(
          child: Image(
            image: AssetImage("assets/icons/white2.png"),
            fit: BoxFit.scaleDown,
          ),
        ),
        Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(50, 130, 0, 20),
            child: Text(
              "Are you looking to Lend or Borrow?",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 20, 20, 0),
            child: SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    LendorRent.lentOrRent = "Lend";
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CreateNewRent()),
                    );
                  },
                  child: Text("Lend")),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 20, 0),
              child: SizedBox(
                height: 40,
                width: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () {
                      LendorRent.lentOrRent = "Borrow";
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewRent()),
                      );
                    },
                    child: Text("Borrow")),
              ))
        ])
      ]),
    );
  }
}
