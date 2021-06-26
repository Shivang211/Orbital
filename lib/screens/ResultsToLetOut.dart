import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/DescriptionRent.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/RentingNewPost.dart';
import 'package:kiraay/screens/SignUpPage.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';

import 'ImagesRentPost.dart';
import 'mainpage.dart';

class Results2 extends StatelessWidget {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  Future<QuerySnapshot<Map<String, dynamic>>> getData() {
    // Handle any data retrieval logic you want
    return FirebaseFirestore.instance
        .collection("posts")
        .where("rental status", isEqualTo: false)
        .where("LendOrRent", isEqualTo: "Rent")
        .get();
  }

  late final String userId;
  String getId() {
    if (SignUp.userUid != null) {
      userId = SignUp.userUid;
      return userId;
    } else {
      userId = Loginpage.userUid;
      return userId;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: body(),
    );
  }

  Widget body() {
    var stream = FirebaseFirestore.instance
        .collection('posts')
        .where("owner id", isNotEqualTo: getId())
        //.where("LendOrRent", isEqualTo: "Rent")
        .snapshots();
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Text("please wait");
          default:
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length == 0) {
                return Text(
                  "No data found : kindly input valid String",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      String id = snapshot.data!.docs[index].id;
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Row(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(120, 10, 10, 0),
                                  child: Text(
                                    "$id",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('posts')
                                          .doc(
                                              '$id') // <-- Doc ID where data should be updated.
                                          .update({
                                        "User Id":
                                            FieldValue.arrayUnion(["$getId()"])
                                      });
                                    },
                                    child: Text("Like"))
                              ])));
                    });
              }
            } else {
              return Text("No data found!",
                  style: TextStyle(color: Colors.white, fontSize: 40));
            }
        }
      },
    );
  }
}
