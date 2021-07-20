import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/register.dart';

import 'mainpage.dart';

class MyLikes extends StatefulWidget {
  @override
  _MyLikesState createState() => _MyLikesState();
}

class _MyLikesState extends State<MyLikes> {
  String name = "";

  // var userId;
  // String getId() {
  //   if (Register.userUid != null) {
  //     userId = Register.userUid;
  //     return userId;
  //   } else {
  //     userId = Login.useruid;
  //     return userId;
  //   }
  // }

  static late String id;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            //centerTitle: true,

            title: Text(
              "My Likes",
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28, color: Color.fromRGBO(239, 132, 125, 1)),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
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
                          MaterialPageRoute(builder: (context) => Homepage()),
                        );
                      },
                      child: Icon(
                        Icons.person_pin,
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
                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
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

        // title:
        // Padding(
        //   padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        //   child: TextFormField(
        //     style: TextStyle(
        //       color: Colors.black,
        //     ),
        //     cursorColor: Colors.white,
        //     decoration: InputDecoration(
        //       prefixIcon: Icon(Icons.search),
        //       enabledBorder: OutlineInputBorder(
        //         borderSide: BorderSide(
        //           color: Colors.white,
        //         ),
        //         borderRadius: BorderRadius.circular(30.0),
        //       ),
        //       fillColor: Colors.white,
        //       filled: true,
        //       hintText: "Search",
        //       labelText: "  Search the liked item",
        //       labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
        //       hintStyle: TextStyle(
        //         color: Colors.grey,
        //       ),
        //     ),
        //     onChanged: (val) {
        //       setState(() {
        //         name = val;
        //       });
        //     },
        //   ),
        // ),

        body: Stack(children: [
          Positioned.fill(
            child: Image(
              image: AssetImage("assets/icons/white5.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 38, top: 20.0),
                child: Icon(
                  Icons.thumb_up_rounded,
                  color: Color.fromRGBO(239, 132, 125, 1),
                  size: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 50.0),
                child: Text("Items you have liked:",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: (name != "" && name != null)
                      ? FirebaseFirestore.instance
                          .collection('posts')
                          .where("caseSearch", arrayContains: name)
                          .where("User Id", arrayContains: Homepage.telegramId)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("posts")
                          .where("User Id", arrayContains: Homepage.telegramId)
                          .snapshots(),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
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
                              id = snapshot.data!.docs[index].id;
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              if (data['rental status'] == true) {
                                return Column(children: [
                                  Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white60, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Colors.white,
                                    child: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopup(context, data),
                                        );
                                      },
                                      child: SizedBox(
                                        //width: double.infinity,
                                        height: 120,
                                        child: Column(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        54, 10, 0, 20),
                                                child: Row(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 2),
                                                    child: Icon(Icons.thumb_up,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                      "${(data["User Id"].length)}")
                                                ]),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "${data['item_name']}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 20)),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  )
                                ]);
                              } else {
                                return Column(children: [
                                  Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.greenAccent, width: 1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    color: Colors.white,
                                    child: MaterialButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              _buildPopupDialog(context, data),
                                        );
                                      },
                                      child: SizedBox(
                                        //width: double.infinity,
                                        height: 120,

                                        child: Column(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        54, 10, 0, 20),
                                                child: Row(children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 2),
                                                    child: Icon(Icons.thumb_up,
                                                        color: Colors.grey),
                                                  ),
                                                  Text(
                                                      "${(data["User Id"].length)}")
                                                ]),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "${data['item_name']}",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 20)),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  )
                                ]);
                              }
                            },
                          );
                  },
                ),
              ),
            ],
          ),
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
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              "(The owner of this post is looking to ${data['LendOrRent']} this item)",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
            ),
          )
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
              var id = data['owner id'] + data['item_name'];
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc('$id') // <-- Doc ID where data should be updated.
                  .update({
                "User Id": FieldValue.arrayRemove(["${Homepage.telegramId}"])
              });
              Navigator.of(context).pop();
            },
            child: Text("Unlike")),
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

  Widget _buildPopup(BuildContext context, DocumentSnapshot data) {
    return new AlertDialog(
      title: Text(data['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              "Sorry, this item is unavailable right now. Check later for updates"),
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
              var id = data['owner id'] + data['item_name'];
              FirebaseFirestore.instance
                  .collection('posts')
                  .doc('$id') // <-- Doc ID where data should be updated.
                  .update({
                "User Id": FieldValue.arrayRemove(["${Homepage.telegramId}"])
              });
              Navigator.of(context).pop();
            },
            child: Text("Unlike")),
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
