import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/RentingNewPost.dart';
import 'package:kiraay/screens/loginpage.dart';

class CreateNewPost extends StatefulWidget {
  @override
  _CreateNewPostState createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
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
        body: Center(
            child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Text(
                " Choose a category:",
                style: TextStyle(color: Colors.white, fontSize: 24),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 20, 0),
              child: Row(
                children: [
                  SizedBox(
                      width: 160.0,
                      height: 35.0,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateNewRent()),
                            );
                          },
                          child: Text("Renting",
                              style: TextStyle(color: Colors.blue)),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: SizedBox(
                          width: 160.0,
                          height: 35.0,
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Meeting new people",
                                  style: TextStyle(color: Colors.blue)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))))))
                ],
              ))
        ])));
  }
}
