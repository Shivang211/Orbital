import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/CreatenewPost.dart';
import 'package:kiraay/screens/LendorRent.dart';
import 'package:kiraay/screens/Meetnewpeople.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/ResultsToLetOut.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'RentingNewPost.dart';
import 'Results.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
  static var searchString;
}

class _MainpageState extends State<Mainpage> {
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
      backgroundColor: Colors.white10,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Kiraay",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28, foreground: Paint()..shader = linearGradient),
          ),
        ),
      ),
      body: Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 70, 0, 40),
              child: Text(
                "So What are you looking for today?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: TextFormField(
                // onChanged: (val) {
                //   initiateSearch(val);
                // },
                decoration: InputDecoration(
                    labelText: "Item name",
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.search),
                      iconSize: 20,
                      onPressed: () {},
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.white,
                    filled: true),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Search is empty';
                  }
                  Mainpage.searchString = text;
                  return null;
                },
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _onSearch();
                    // TODO submit
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Results()),
                    );
                  }
                },
                child: Text("Search")),
            Padding(
                padding: EdgeInsets.fromLTRB(130, 200, 0, 0),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 20),
                        child: Text("Looking to Lend Items?",
                            style: TextStyle(color: Colors.white)))
                  ],
                )),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  _showAllRent();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Results2()),
                  );
                },
                child: Text("See What Others are Looking for")),
            Padding(
                padding: EdgeInsets.fromLTRB(5, 80, 0, 0),
                child: Row(children: [
                  IconButton(
                    icon: Icon(Icons.person_pin, size: 65, color: Colors.white),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(270, 30, 0, 0),
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LendorRent()),
                        );
                      },
                    ),
                  )
                ]))
          ])),
    );
  }

  void _onSearch() {
    FirebaseFirestore.instance
        .collection("posts")
        .where(
          "item_name",
          isEqualTo: Mainpage.searchString,
        )
        .where("rental status", isEqualTo: false)
        .where("LendOrRent", isEqualTo: "Lend")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  void _showAllRent() {
    FirebaseFirestore.instance
        .collection("posts")
        .where("rental status", isEqualTo: false)
        .where("LendOrRent", isEqualTo: "Rent")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data());
      });
    });
  }
}
