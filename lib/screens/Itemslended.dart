import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/MyMatches.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/searchPage.dart';

import 'LendorRent.dart';
import 'MyLikes.dart';
import 'mainpage.dart';

class ItemsLended extends StatefulWidget {
  @override
  _ItemsLendedState createState() => _ItemsLendedState();
}

class _ItemsLendedState extends State<ItemsLended> {
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
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
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
                    size: 40.0,
                  ),
                  constraints: BoxConstraints.tightFor(
                    width: 56.0,
                    height: 56.0,
                  ),
                )),
          ),
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
                padding: EdgeInsets.fromLTRB(0, 8, 20, 0),
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 6, 20, 0),
              //   child: Text(
              //     "Search",
              //     style: TextStyle(fontSize: 10),
              //   ),
              // )
            ]),
            Column(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 20, 5),
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
                          MaterialPageRoute(builder: (context) => LendorRent()),
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
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(0, 6, 20, 0),
              //   child: Text(
              //     "Add post",
              //     style: TextStyle(fontSize: 10),
              //   ),
              // )
            ])
          ],
        ),
      ),
      body:
          // Stack(children: [
          //   Positioned.fill(
          //     child: Image(
          //       image: AssetImage("assets/icons/white2.png"),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      //   child: Text(
                      //     "Looking for something to rent?",
                      //     style: TextStyle(color: Colors.black, fontSize: 15),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 170,
                      //   child: ElevatedButton(
                      //       style: ButtonStyle(
                      //           backgroundColor:
                      //               MaterialStateProperty.all(Colors.black),
                      //           shape:
                      //               MaterialStateProperty.all<RoundedRectangleBorder>(
                      //                   RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(18.0),
                      //           ))),
                      //       onPressed: () {
                      //         Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => CloudFirestoreSearch()),
                      //         );
                      //       },
                      //       child: Text("Search Now")),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 40),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Items you have lent to other people:",
                                style: (TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
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
                                  .where("rental status", isEqualTo: true)
                                  .where("LendOrRent", isEqualTo: "Rent")
                                  .where("owner id",
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.email)
                                  .snapshots(),
                          builder: (context, snapshot) {
                            return (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                ? Center(child: CircularProgressIndicator())
                                : GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 25,
                                    ),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot data =
                                          snapshot.data!.docs[index];
                                      item_name =
                                          user!.email! + data['item_name'];
                                      List<Object> newList =
                                          data['User Id'] as List<Object>;
                                      if (data['owner id'] == user.email) {
                                        id = snapshot.data!.docs[index].id;
                                        return Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          color: Colors.white,
                                          child: Column(children: [
                                            MaterialButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          _buildPopup(
                                                              context, data),
                                                );
                                              },
                                              child: SizedBox(
                                                width: double.infinity,
                                                child: Column(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment.center,
                                                    // mainAxisAlignment:
                                                    //     MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                54, 10, 0, 20),
                                                        child: Row(children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 2),
                                                            child: Icon(
                                                                Icons.thumb_up,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        239,
                                                                        132,
                                                                        125,
                                                                        1)),
                                                          ),
                                                          Text(
                                                              "${(data["User Id"].length)}")
                                                        ]),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "${data['item_name']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 20)),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                        );
                                      } else if ((newList
                                          .contains(user.email as Object))) {
                                        id = snapshot.data!.docs[index].id;
                                        return Card(
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          //elevation: 0,
                                          color: Colors.white,
                                          child: Column(children: [
                                            MaterialButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _buildPopupAlreadyLiked(
                                                          context, data),
                                                );
                                              },
                                              child: SizedBox(
                                                //width: double.infinity,
                                                //height: 70,
                                                child: Column(
                                                    // alignment: Alignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                54, 10, 0, 20),
                                                        child: Row(children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 2),
                                                            child: Icon(
                                                                Icons.thumb_up,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        239,
                                                                        132,
                                                                        125,
                                                                        1)),
                                                          ),
                                                          Text(
                                                              "${(data["User Id"].length)}")
                                                        ]),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "${data['item_name']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 20)),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                        );
                                      } else {
                                        id = snapshot.data!.docs[index].id;
                                        return Card(
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.greenAccent,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          elevation: 10,
                                          color: Colors.white,
                                          child: Column(children: [
                                            MaterialButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      _buildPopupDialog(
                                                          context,
                                                          data,
                                                          data['item_name']),
                                                );
                                              },
                                              child: SizedBox(
                                                //width: double.infinity,
                                                //height: 70,
                                                child: Column(
                                                    // alignment: Alignment.center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                54, 10, 0, 20),
                                                        child: Row(children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 2),
                                                            child: Icon(
                                                                Icons.thumb_up,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Text(
                                                              "${(data["User Id"].length)}")
                                                        ]),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            "${data['item_name']}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 20)),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ]),
                                        );
                                      }
                                    });
                          },
                        ),
                      )
                    ]),
              )),
      //])
    );
  }

  Widget _buildPopupDialog(
      BuildContext context, DocumentSnapshot data, String itemName) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
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
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              var addToArray = getId();
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc('${data['owner id']}' +
                      itemName) // <-- Doc ID where data should be updated.
                  .update({
                "User Id": FieldValue.arrayUnion(["${user!.email}"])
              });
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupLike(context, data),
              );
            },
            child: Text("Like")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
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
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
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
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
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
                backgroundColor:
                    MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
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
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
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
              Navigator.of(context).pop();
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
}
