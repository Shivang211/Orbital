import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/Login.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/register.dart';

import 'Deleted.dart';
import 'SignUpPage.dart';
import 'mainpage.dart';

class MyMatches extends StatefulWidget {
  @override
  _MyMatchesState createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> {
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.black,
          title: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "Search",
                labelText: "  Search the item you are looking for",
                labelStyle: TextStyle(color: Colors.grey, fontSize: 14),
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
        body: Stack(children: [
          Positioned.fill(
            child: Image(
              image: AssetImage("assets/icons/white2.png"),
              fit: BoxFit.contain,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance
                    .collection('posts')
                    .where("caseSearch", arrayContains: name)
                    .where("rental status", isEqualTo: false)
                    .where("owner id", isEqualTo: user!.email)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("posts")
                    .where("rental status", isEqualTo: false)
                    .where("owner id", isEqualTo: user!.email)
                    .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        id = snapshot.data!.docs[index].id;
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        return Column(children: [
                          MaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context, data),
                              );
                            },
                            child: Text(data['item_name']),
                          )
                          // Card(
                          //   child: Row(
                          //     children: <Widget>[
                          //       MaterialButton(
                          //         child: Text(
                          //           data['item_name'],
                          //           style: TextStyle(
                          //             fontWeight: FontWeight.w700,
                          //             fontSize: 20,
                          //           ),
                          //         ),
                          //         onPressed: () {
                          //     showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) =>
                          //           _buildPopupDialog(context, data),
                          //     );
                          //   },
                          // ),
                          //       SizedBox(width: 25, height: 100),
                          //       Text(
                          //         data['description'],
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.w700,
                          //           fontSize: 20,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ]);
                      },
                    );
            },
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
              Navigator.of(context).pop();
            },
            child: Text("Like")),
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
