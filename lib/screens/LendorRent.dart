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
import 'RentingNewPost.dart';
import 'Results.dart';

class LendorRent extends StatefulWidget {
  @override
  _LendorRentState createState() => _LendorRentState();
  static var lentOrRent;
}

class _LendorRentState extends State<LendorRent> {
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  // ignore: deprecated_member_use
  // List names = new List();
  Icon _searchIcon = Icon(Icons.search);

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.teal,
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
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 200, 0, 20),
              child: Text(
                "Are you looking to lend or rent in?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Row(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(120, 0, 20, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () {
                      LendorRent.lentOrRent = "Lend";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewRent()),
                      );
                    },
                    child: Text("Lend")),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () {
                      LendorRent.lentOrRent = "Rent";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewRent()),
                      );
                    },
                    child: Text("Rent In")),
              )
            ])
          ])),
    );
  }
}
