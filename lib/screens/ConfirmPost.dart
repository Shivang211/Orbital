import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/DescriptionRent.dart';
import 'package:kiraay/screens/LendorRent.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/Posted.dart';
import 'package:kiraay/screens/RentingNewPost.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/register.dart';

import 'ImagesRentPost.dart';
import 'Login.dart';
import 'SignUpPage.dart';

class ConfirmPost extends StatefulWidget {
  @override
  _ConfirmPostState createState() => _ConfirmPostState();
}

class _ConfirmPostState extends State<ConfirmPost> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  static late String docRef;

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }

  Future<void> addPost() {
    //Call the user's CollectionReference to add a new user

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    String? name = user!.email! + item_name;
    //Login.useruid = currentUser!.uid;
    if (Login.useruid != null) {
      return posts.doc("$name}").set({
        'owner id': user.email,
        'item_name': item_name,
        'description': description,
        'rental status': RentalStatus,
        "User Id": FieldValue.arrayUnion([]),
        "LendOrRent": LendorRent.lentOrRent,
        "caseSearch": setSearchParam(item_name),
      });
    } else {
      return posts.doc("$name").set({
        'owner id': user.email,
        'item_name': item_name,
        'description': description,
        'rental status': RentalStatus,
        "User Id": FieldValue.arrayUnion([]),
        "LendOrRent": LendorRent.lentOrRent,
        "caseSearch": setSearchParam(item_name),
      });
    }
  }

  var item_name = CreateNewRent.item_name;
  var description = DescriptionRent.description;
  var ownerId;
  var renteeId;
  var RentalStatus = false;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Post Summary",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, foreground: Paint()..shader = linearGradient),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
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
      body: Stack(children: [
        Positioned.fill(
          child: Image(
            image: AssetImage("assets/icons/white2.png"),
            fit: BoxFit.contain,
          ),
        ),
        Center(
          child: Column(
            children: <Widget>[
              Row(children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 100, 10, 10),
                    child: Text(
                      "Item name:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                  child: Text("$item_name",
                      style: TextStyle(
                          color: Color.fromRGBO(239, 132, 125, 1),
                          fontSize: 20)),
                ),
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 10, 10),
                  child: Text("Description:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontStyle: FontStyle.italic)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text("$description",
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 20)),
                ),
              ]),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: ElevatedButton(
                      //icon: Icon(Icons.arrow_right_alt),
                      child: Text("Edit Post"),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LendorRent()),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))))),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ElevatedButton(
                      //icon: Icon(Icons.arrow_right_alt),
                      child: Text("Create Post"),
                      onPressed: () {
                        addPost();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildPopupDialog(context),
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))))
            ],
          ),
        )
      ]),
    );
  }

  void _onPressed(uid) {
    FirebaseFirestore.instance.collection('posts').doc(uid).set(
        {"User Id": FieldValue.arrayUnion([])},
        SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Congratulations'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Post Created!"),
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
                MaterialPageRoute(builder: (context) => Mainpage()),
              );
            },
            child: Text("Home"))
      ],
    );
  }
}
