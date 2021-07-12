import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/main.dart';
import 'package:kiraay/screens/CreatenewPost.dart';
import 'package:kiraay/screens/LendorRent.dart';
import 'package:kiraay/screens/Liked.dart';
import 'package:kiraay/screens/Login.dart';
import 'package:kiraay/screens/Meetnewpeople.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/MyLikes.dart';
import 'package:kiraay/screens/MyMatches.dart';
import 'package:kiraay/screens/ResultsToLetOut.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:animated_background/animated_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiraay/screens/searchPage.dart';
import 'RentingNewPost.dart';
import 'Results.dart';
import 'register.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
  static var searchString;
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;

late String userId;
String getId() {
  if (Register.userUid != null) {
    userId = Register.userUid;
    return userId;
  } else {
    userId = FirebaseAuth.instance.currentUser!.uid;
    return userId;
  }
}

late String id;

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

  String name = "";
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    int _index = 0;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                "Kiraay",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28, foreground: Paint()..shader = linearGradient),
              ),
            ),
            actions: [
              Column(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                      height: 34,
                      width: 34,
                      child: RawMaterialButton(
                        elevation: 5.0,
                        shape: CircleBorder(),
                        fillColor: Colors.black,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Homepage()),
                          );
                        },
                        child: Icon(
                          Icons.person_pin,
                          color: Colors.white,
                          size: 34.0,
                        ),
                        constraints: BoxConstraints.tightFor(
                          width: 56.0,
                          height: 56.0,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 20, 0),
                  child: Text(
                    "Profile",
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ]),
              Column(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 2, 20, 5),
                  child: Container(
                      height: 27,
                      width: 28,
                      child: RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(),
                        fillColor: Colors.white,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LendorRent()),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 30.0,
                        ),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 6, 20, 0),
                  child: Text(
                    "Add post",
                    style: TextStyle(fontSize: 10),
                  ),
                )
              ])
            ],
          ),
        ),
        body: Stack(children: [
          Positioned.fill(
            child: Image(
              image: AssetImage("assets/icons/white2.png"),
              fit: BoxFit.fill,
            ),
          ),
          Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Text(
                    "Looking for something to rent?",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: 170,
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CloudFirestoreSearch()),
                        );
                      },
                      child: Text("Search Now")),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 0, 20),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("What other people are looking for:",
                          style: (TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)))),
                ),
                Expanded(
                  // wrap in Expanded
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (name != "" && name != null)
                        ? FirebaseFirestore.instance
                            .collection('posts')
                            .where("caseSearch", arrayContains: name)
                            .where("rental status", isEqualTo: false)
                            .where("LendorRent", isNotEqualTo: "Lend")
                            // .where("owner id",
                            //     isNotEqualTo:
                            //         FirebaseAuth.instance.currentUser!.uid)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("posts")
                            .where("rental status", isEqualTo: false)
                            .where("LendOrRent", isEqualTo: "Rent")
                            //.where("owner id", isNotEqualTo: user!.email)
                            .snapshots(),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                id = snapshot.data!.docs[index].id;
                                DocumentSnapshot data =
                                    snapshot.data!.docs[index];
                                item_name = user!.email! + data['item_name'];
                                List<Object> newList =
                                    data['User Id'] as List<Object>;
                                if (data['owner id'] == user.email) {
                                  return Column(children: [
                                    MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopup(context, data),
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("${data['item_name']}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ]);
                                } else if ((newList
                                    .contains(user.email as Object))) {
                                  return Column(children: [
                                    MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupAlreadyLiked(
                                                  context, data),
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 70,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text("${data['item_name']}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ]);
                                } else {
                                  return Column(children: [
                                    MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupDialog(context, data),
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 70,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(data['item_name'],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20)),
                                        ),
                                      ),
                                    ),
                                  ]);
                                }
                              });
                    },
                  ),
                )
              ])),
        ]));
  }

  Widget _buildPopupDialog(BuildContext context, DocumentSnapshot data) {
    return new AlertDialog(
      title: Text(data['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data['description']),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
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
                "User Id": FieldValue.arrayUnion(["${user!.email}"])
              });
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupLike(context, data),
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

  late String? item_name;

  Widget _buildPopup(BuildContext context, DocumentSnapshot data) {
    return new AlertDialog(
      title: Text(data['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "This post is created by you, please check more info under My Items"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyMatches()),
              );
            },
            child: Text("My Items")),
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

  Widget _buildPopupAlreadyLiked(BuildContext context, DocumentSnapshot data) {
    return new AlertDialog(
      title: Text(data['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("You have already liked this post"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyLikes()),
              );
            },
            child: Text("My Liked")),
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

  Widget _buildPopupLike(BuildContext context, DocumentSnapshot data) {
    return new AlertDialog(
      title: Text(data['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Item Liked!!"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyLikes()),
              );
            },
            child: Text("My Likes")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Mainpage()),
              );
            },
            child: Text("Close"))
      ],
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
