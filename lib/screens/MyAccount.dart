// @dart=2.9
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
  static var telegramId;
}

class _HomepageState extends State<Homepage> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  var telegramId;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    var collection = FirebaseFirestore.instance
        .collection('users')
        .where('email Id', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            //centerTitle: true,

            title: Text(
              "My Account",
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
                        padding: const EdgeInsets.only(bottom: 8, top: 20.0),
                        child: Icon(
                          Icons.person_pin,
                          color: Color.fromRGBO(239, 132, 125, 1),
                          size: 180,
                        ),
                      ),
                      // Text("${FirebaseAuth.instance.currentUser.email}"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 35.0),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(
                                        '${FirebaseAuth.instance.currentUser.email}')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new Text("Loading");
                                  }
                                  var userD = snapshot.data;
                                  Homepage.telegramId = userD['telegram id'];
                                  return Text(
                                    "@${Homepage.telegramId}",
                                    style: TextStyle(fontSize: 23),
                                  );
                                }),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialogEditTelegramId(context),
                                );
                              },
                              icon: Icon(Icons.edit))
                        ],
                      ),
                      Text(
                        "${FirebaseAuth.instance.currentUser.email}",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => MyLikes()));
                              },
                              label: Text(
                                "Liked Items",
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => MyMatches()));
                              },
                              label: Text(
                                "Posts Created",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              icon: Icon(
                                Icons.post_add,
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => ItemsLended()));
                              },
                              label: Text(
                                "Lent Items",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              icon: Icon(
                                Icons.shopping_cart,
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => ItemsRented()));
                              },
                              label: Text(
                                "Borrowed Items",
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(135, 68, 15, 20),
                            //   child: IconButton(
                            //     icon: Icon(Icons.delete,
                            //         size: 33, color: Colors.grey),
                            //     onPressed: () {
                            //       // Navigator.push(
                            //       //   context,
                            //       //   MaterialPageRoute(builder: (context) => Setting()),
                            //       // );
                            // showDialog(
                            //   context: context,
                            //   builder: (BuildContext context) =>
                            //       _buildPopupDialog(context),
                            // );
                            //     },
                            //   ),
                            // ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 70, 0, 0),
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
                                label: Text(
                                  "Sign Out",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                icon: Icon(
                                  Icons.exit_to_app_sharp,
                                  //size: 33,
                                  color: Colors.grey,
                                ),
                                onPressed: () async {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(context),
                                  );
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

  Widget _buildPopupDialogEditTelegramId(BuildContext context) {
    return new AlertDialog(
      title: Text("Edit Telegram Id"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            style: TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.grey,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.edit),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(
              //     color: Colors.black,
              //   ),
              //   borderRadius: BorderRadius.circular(30.0),
              // ),
              fillColor: Colors.white,
              // filled: true,
              hintText: "Telegram Id",
              labelText: "Enter your telegram id",
              labelStyle: TextStyle(
                color: Colors.grey,
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
            onChanged: (val) {
              setState(() {
                telegramId = val;
              });
            },
          ),
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
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.email)
                  .update({'telegram id': telegramId});
              Navigator.of(context).pop();
            },
            child: Text("Save")),
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

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text("We are sad to see you go :'("),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Are you sure you want to Log Out?"),
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
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => Login()));
            },
            child: Text("Log Out")),
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

  void deleteUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc('${FirebaseAuth.instance.currentUser.email}')
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }
}
