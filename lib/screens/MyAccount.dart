import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/Login.dart';
import 'package:kiraay/screens/MyLikes.dart';
import 'package:kiraay/screens/MyMatches.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/searchPage.dart';

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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    var collection = FirebaseFirestore.instance
        .collection('users')
        .where('email Id', isEqualTo: user!.email)
        .get();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            //centerTitle: true,

            title: Text(
              "My Account",
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25, color: Color.fromRGBO(239, 132, 125, 1)),
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
        body: Stack(
          children: [
            Positioned.fill(
              child: Image(
                image: AssetImage("assets/icons/white5.png"),
                fit: BoxFit.fitHeight,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Icon(
                          Icons.person_pin,
                          color: Color.fromRGBO(239, 132, 125, 1),
                          size: 150,
                        ),
                      ),
                      Text("${user.email}"),
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0),
                        child: Container(
                          height: 40,
                          width: 170,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(10),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {},
                              label: Text(
                                "My Likes",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              icon: Icon(
                                Icons.thumb_up,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 40,
                          width: 170,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(10),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {},
                              label: Text(
                                "My Matches",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              icon: Icon(
                                Icons.thumb_up,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 40,
                          width: 170,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.greenAccent),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {},
                              label: Text(
                                "Lent Items",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.thumb_up,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Container(
                          height: 40,
                          width: 170,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.greenAccent),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () {},
                              label: Text(
                                "Borrowed Items",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.thumb_up,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(135, 68, 15, 20),
                          child: IconButton(
                            icon: Icon(Icons.delete,
                                size: 33, color: Colors.grey),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Setting()),
                              // );
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 50, 30, 0),
                          child: IconButton(
                            icon: Icon(
                              Icons.exit_to_app_sharp,
                              size: 33,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Login()));
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => Loginpage()),
                              // );
                            },
                          ),
                        ),
                      ])
                    ]),
              ),
            )
          ],
        ));
  }
  // Padding(
  //   padding: const EdgeInsets.fromLTRB(80, 60, 0, 30),
  //   child:
  //   Row(children: [
  //     Card(
  //       elevation: 10,
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(color: Colors.greenAccent, width: 1),
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       color: Colors.white,
  //       child: MaterialButton(
  //         onPressed: () {},
  //         child: SizedBox(
  //           width: 80,
  //           height: 100,
  //           child: Column(children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(54, 10, 0, 10),
  //               child: Row(children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 2),
  //                   child:
  //                       Icon(Icons.thumb_up, color: Colors.grey),
  //                 ),
  //               ]),
  //             ),
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Text("My    Likes",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 18)),
  //             ),
  //           ]),
  //         ),
  //       ),
  //     ),
  //     Card(
  //       elevation: 10,
  //       shape: RoundedRectangleBorder(
  //         side: BorderSide(color: Colors.greenAccent, width: 1),
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       color: Colors.white,
  //       child: MaterialButton(
  //         onPressed: () {},
  //         child: SizedBox(
  //           width: 80,
  //           height: 100,
  //           child: Column(children: [
  //             Padding(
  //               padding: const EdgeInsets.fromLTRB(54, 10, 0, 10),
  //               child: Row(children: [
  //                 Padding(
  //                   padding: const EdgeInsets.only(right: 2),
  //                   child: Icon(Icons.person_add_alt_sharp,
  //                       color: Colors.grey),
  //                 ),
  //               ]),
  //             ),
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Text("My Matches",
  //                   style: TextStyle(
  //                       color: Colors.black,
  //                       fontWeight: FontWeight.w300,
  //                       fontSize: 18)),
  //             ),
  //           ]),
  //         ),
  //       ),
  //     ),
  //   ]),
  // ),
  // Padding(
  //     padding: EdgeInsets.fromLTRB(80, 0, 0, 30),
  //     child: Row(children: [
  //       Card(
  //         elevation: 10,
  //         shape: RoundedRectangleBorder(
  //           side: BorderSide(color: Colors.greenAccent, width: 1),
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         color: Colors.white,
  //         child: MaterialButton(
  //           onPressed: () {},
  //           child: SizedBox(
  //             width: 80,
  //             height: 100,
  //             child: Column(children: [
  //               Padding(
  //                 padding:
  //                     const EdgeInsets.fromLTRB(54, 10, 0, 10),
  //                 child: Row(children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 2),
  //                     child:
  //                         Icon(Icons.shop_2, color: Colors.grey),
  //                   ),
  //                 ]),
  //               ),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Borrowed Items",
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w300,
  //                         fontSize: 18)),
  //               ),
  //             ]),
  //           ),
  //         ),
  //       ),
  //       Card(
  //         elevation: 10,
  //         shape: RoundedRectangleBorder(
  //           side: BorderSide(color: Colors.greenAccent, width: 1),
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //         color: Colors.white,
  //         child: MaterialButton(
  //           onPressed: () {},
  //           child: SizedBox(
  //             width: 80,
  //             height: 100,
  //             child: Column(children: [
  //               Padding(
  //                 padding:
  //                     const EdgeInsets.fromLTRB(54, 10, 0, 10),
  //                 child: Row(children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(right: 2),
  //                     child: Icon(Icons.clean_hands,
  //                         color: Colors.grey),
  //                   ),
  //                 ]),
  //               ),
  //               Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text("Lent   Items",
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.w300,
  //                         fontSize: 18)),
  //               ),
  //             ]),
  //           ),
  //         ),
  //       ),
  //     ])),
  // Row(
  //   children: [
  //     Padding(
  //       padding: EdgeInsets.fromLTRB(135, 68, 15, 20),
  //       child: IconButton(
  //         icon: Icon(Icons.delete, size: 33, color: Colors.grey),
  //         onPressed: () {
  //           // Navigator.push(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => Setting()),
  //           // );
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) =>
  //                 _buildPopupDialog(context),
  //           );
  //         },
  //       ),
  //     ),
  //     Padding(
  //       padding: EdgeInsets.fromLTRB(5, 50, 30, 0),
  //       child: IconButton(
  //         icon: Icon(
  //           Icons.exit_to_app_sharp,
  //           size: 33,
  //           color: Colors.grey,
  //         ),
  //         onPressed: () async {
  //           await FirebaseAuth.instance.signOut();
  //           Navigator.pushReplacement(
  //               context,
  //               new MaterialPageRoute(
  //                   builder: (context) => Login()));
  //           // Navigator.pushReplacement(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => Loginpage()),
  //           // );
  //         },
  //       ),
  //     ),
  //   ],
  // )

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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text("Delete Account"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are you sure you want to delete your account"),
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
            onPressed: () async {
              deleteUser();
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text(" Confirm Delete")),
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

  Future<void> deleteUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${user!.email}')
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
