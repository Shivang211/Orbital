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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            //centerTitle: true,

            title: Text(
              "Lent Items",
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
                padding: const EdgeInsets.only(bottom: 38, top: 30.0),
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: Color.fromRGBO(239, 132, 125, 1),
                  size: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 50.0),
                child: Text("Items you have lent:",
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("posts")
                      .where("rental status", isEqualTo: true)
                      .where('LendOrRent', isEqualTo: "Borrow")
                      .where("rentee id", isEqualTo: Homepage.telegramId)
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
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];
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

                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              64, 10, 0, 20),
                                          child: Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 2),
                                              child: Icon(
                                                  Icons.shopping_cart_rounded,
                                                  color: Colors.red),
                                            ),
                                          ]),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("${data['item_name']}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 20)),
                                        ),
                                      ]),
                                    ),
                                  ),
                                )
                              ]);
                            });
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
          SingleChildScrollView(
            child: Text("${data['description']}"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "(Item has been lent)",
              style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.0),
                ))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"))
      ],
    );
  }
}
