import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/DescriptionRent.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/RentingNewPost.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';

import 'ImagesRentPost.dart';
import 'Liked.dart';
import 'SignUpPage.dart';
import 'mainpage.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
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

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    var searchString = Mainpage.searchString;
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
  static late String id;
  Widget body() {
    var stream = FirebaseFirestore.instance
        .collection('posts')
        .where("LendOrRent", isEqualTo: "Lend")
        .where("item_name", isEqualTo: Mainpage.searchString)
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
                  "No data found",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                );
              } else {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      id = snapshot.data!.docs[index].id;
                      return Column(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 296, 10),
                          child: Text("Showing Results:",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 250, 10),
                          child: Text("tap on the item for more info",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        ),
                        Center(
                          child:
                              //Row(children: [
                              MaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                            },
                            child: Text(
                              "$id",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 30),
                            ),
                          ),
                        )
                      ]);
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
      title: const Text('Item Name'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Description"),
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
              var addToArray = getId();
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc('$id') // <-- Doc ID where data should be updated.
                  .update({
                "User Id": FieldValue.arrayUnion(["$addToArray"])
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Liked()),
              );
            },
            child: Text("Like")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
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
