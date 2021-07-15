import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiraay/screens/Liked.dart';
import 'package:kiraay/screens/MyLikes.dart';
import 'package:kiraay/screens/MyMatches.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/register.dart';

import 'Login.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String name = "";

  // var userId;
  String getId() {
    if (Register.userUid != null) {
      userId = Register.userUid;
      return userId;
    } else {
      userId = Login.useruid;
      return userId;
    }
  }

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
            padding: EdgeInsets.fromLTRB(40, 0, 0, 5),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
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
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
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
              fit: BoxFit.fitWidth,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: (name != "" && name != null)
                ? FirebaseFirestore.instance
                    .collection('posts')
                    .where("caseSearch", arrayContains: name)
                    .where("rental status", isEqualTo: false)
                    .where("LendOrRent", isEqualTo: "Lend")
                    //.where("owner id", isNotEqualTo: getId())
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection("posts")
                    .where("rental status", isEqualTo: false)
                    .where("LendOrRent", isEqualTo: "Lend")
                    .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 25,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        id = snapshot.data!.docs[index].id;
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        item_name = user!.email! + data['item_name'];
                        List<Object> newList = data['User Id'] as List<Object>;
                        if (data['owner id'] == user!.email) {
                          id = snapshot.data!.docs[index].id;
                          return Card(
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
                                      _buildPopup(context, data),
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
                                        padding: const EdgeInsets.fromLTRB(
                                            54, 10, 0, 20),
                                        child: Row(children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 2),
                                            child: Icon(Icons.thumb_up,
                                                color: Colors.grey),
                                          ),
                                          Text("${(data["User Id"].length)}")
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
                          );
                        } else if ((newList.contains(user!.email as Object))) {
                          id = snapshot.data!.docs[index].id;
                          return Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.greenAccent, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            //elevation: 0,
                            color: Colors.white,
                            child: Column(children: [
                              MaterialButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupAlreadyLiked(context, data),
                                  );
                                },
                                child: SizedBox(
                                  child: Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          54, 10, 0, 20),
                                      child: Row(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Icon(Icons.thumb_up,
                                              color: Color.fromRGBO(
                                                  239, 132, 125, 1)),
                                        ),
                                        Text("${(data["User Id"].length)}")
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
                            ]),
                          );
                        } else {
                          id = snapshot.data!.docs[index].id;
                          return Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.greenAccent, width: 1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 10,
                            color: Colors.white,
                            child: Column(children: [
                              MaterialButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(
                                            context, data, data['item_name']),
                                  );
                                },
                                child: SizedBox(
                                  //width: double.infinity,
                                  //height: 70,
                                  child: Column(
                                      // alignment: Alignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              54, 10, 0, 20),
                                          child: Row(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 2),
                                              child: Icon(Icons.thumb_up,
                                                  color: Colors.grey),
                                            ),
                                            Text("${(data["User Id"].length)}")
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
                            ]),
                          );
                        }
                      });
            },
          ),
        ]));
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
            onPressed: () {},
            child: Text("Close"))
      ],
    );
  }
}
