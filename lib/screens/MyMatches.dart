import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/loginpage.dart';

import 'Deleted.dart';
import 'SignUpPage.dart';
import 'mainpage.dart';

class MyMatches extends StatefulWidget {
  @override
  _MyMatchesState createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  var userId;
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
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.home, size: 33),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Mainpage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: body());
  }
  //],
  //),
  //),
  // );
  //}

  Future<void> deleteUser(String id) {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc('$id')
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Widget body() {
    var stream = FirebaseFirestore.instance
        .collection('posts')
        .where("owner id", isEqualTo: getId())
        .where("User Id", isNotEqualTo: ["Empty"]).snapshots();
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
                  "No data found",
                  style: TextStyle(color: Colors.white, fontSize: 40),
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
                              padding: EdgeInsets.fromLTRB(120, 10, 0, 0),
                              child: Row(children: [
                                Text(
                                  "$id",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.red),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                            ))),
                                        onPressed: () {
                                          deleteUser(id);
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialog(context),
                                          );
                                        },
                                        child: Text("Delete")))
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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Deleted'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Post Deleted!"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"))
      ],
    );
  }
}
