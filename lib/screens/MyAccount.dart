import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyLikes.dart';
import 'package:kiraay/screens/MyMatches.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/mainpage.dart';

import 'Itemslended.dart';
import 'PendingItems.dart';
import 'Settings.dart';
import 'SignUpPage.dart';
import 'itemsRented.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white10,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            centerTitle: true,

            title: Text(
              "My Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25, foreground: Paint()..shader = linearGradient),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.home, size: 33),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Mainpage()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Center(
            child: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 140, 15, 10),
            child: SizedBox(
              width: 200.0,
              height: 40.0,
              child: ElevatedButton(
                child: new Text("My Likes"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLikes()),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 200.0,
                height: 40.0,
                child: ElevatedButton(
                  child: new Text("My Matches"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {
                    _myMatches();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyMatches()),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: SizedBox(
              width: 200.0,
              height: 40.0,
              child: ElevatedButton(
                child: new Text("Items I have rented"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemsRented()),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: SizedBox(
              width: 200.0,
              height: 40.0,
              child: ElevatedButton(
                child: new Text("Items I have lent"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  _lentItems();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemsLended()),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: SizedBox(
              width: 200.0,
              height: 40.0,
              child: ElevatedButton(
                child: new Text("Pending posts"),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                onPressed: () {
                  _pendingPosts();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PendingItems()),
                  );
                },
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(135, 68, 15, 20),
                child: IconButton(
                  icon: Icon(Icons.settings, size: 33, color: Colors.white24),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 50, 30, 0),
                child: IconButton(
                  icon: Icon(Icons.exit_to_app_sharp,
                      size: 33, color: Colors.white24),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                ),
              ),
            ],
          )
        ])));
  }

  void _pendingPosts() {
    if (SignUp.userUid != null) {
      FirebaseFirestore.instance
          .collection("posts")
          .where(
            'owner id',
            isEqualTo: SignUp.userUid,
          )
          .where("rental status", isEqualTo: false)
          .where("User Id", isEqualTo: [])
          .get()
          .then((value) {
            value.docs.forEach((result) {
              print(result.data());
            });
          });
    } else {
      FirebaseFirestore.instance
          .collection("posts")
          .where(
            'owner id',
            isEqualTo: Loginpage.userUid,
          )
          .where("rental status", isEqualTo: false)
          .where("User Id", isEqualTo: [])
          .get()
          .then((value) {
            value.docs.forEach((result) {
              print(result.data());
            });
          });
    }
  }

  void _lentItems() {
    if (SignUp.userUid != null) {
      FirebaseFirestore.instance
          .collection("posts")
          .where(
            'owner id',
            isEqualTo: SignUp.userUid,
          )
          .where("rental status", isEqualTo: true)
          .where("LendOrRent", isEqualTo: "Lend")
          .get()
          .then((value) {
        value.docs.forEach((result) {
          print(result.data());
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection("posts")
          .where(
            'owner id',
            isEqualTo: Loginpage.userUid,
          )
          .where("rental status", isEqualTo: true)
          .where("LendOrRent", isEqualTo: "Lend")
          .get()
          .then((value) {
        value.docs.forEach((result) {
          print(result.data());
        });
      });
    }
  }

  void _myMatches() {
    if (SignUp.userUid != null) {
      FirebaseFirestore.instance
          .collection("posts")
          .where(
            'owner id',
            isEqualTo: SignUp.userUid,
          )
          .where("User Id", isNotEqualTo: [])
          .where("rental status", isEqualTo: false)
          .get()
          .then((value) {
            value.docs.forEach((result) {
              print(result.data());
            });
          });
    } else {
      FirebaseFirestore.instance
          .collection("posts")
          .where(
            'owner id',
            isEqualTo: Loginpage.userUid,
          )
          .where("User Id", isNotEqualTo: [])
          .where("rental status", isEqualTo: false)
          .get()
          .then((value) {
            value.docs.forEach((result) {
              print(result.data());
            });
          });
    }
  }
}
