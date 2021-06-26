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

import 'ImagesRentPost.dart';
import 'SignUpPage.dart';

class ConfirmPost extends StatefulWidget {
  @override
  _ConfirmPostState createState() => _ConfirmPostState();
}

class _ConfirmPostState extends State<ConfirmPost> {
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  static late String docRef;

  Future<void> addPost() {
    //Call the user's CollectionReference to add a new user
    if (SignUp.userUid != null) {
      return posts.doc("$item_name").set({
        'owner id': SignUp.userUid,
        'item_name': item_name,
        'description': description,
        'rental status': RentalStatus,
        "User Id": FieldValue.arrayUnion([]),
        "LendOrRent": LendorRent.lentOrRent,
      });
    } else {
      return posts.doc("$item_name").set({
        'owner id': Loginpage.userUid,
        'item_name': item_name,
        'description': description,
        'rental status': RentalStatus,
        "User Id": FieldValue.arrayUnion([]),
        "LendOrRent": LendorRent.lentOrRent,
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
      backgroundColor: Colors.teal,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.white10,
          centerTitle: true,
          title: Text(
            "Post Summary",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, foreground: Paint()..shader = linearGradient),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(100, 100, 10, 10),
                  child: Text(
                    "Item name:",
                    style: TextStyle(
                        color: Color.fromRGBO(239, 132, 125, 1), fontSize: 20),
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: Text("$item_name",
                    style: TextStyle(
                        color: Color.fromRGBO(239, 132, 125, 1), fontSize: 20)),
              ),
            ]),
            Row(children: [
              Padding(
                padding: EdgeInsets.fromLTRB(90, 40, 10, 10),
                child: Text("Description:",
                    style: TextStyle(
                        color: Color.fromRGBO(239, 132, 125, 1), fontSize: 20)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text("$description",
                    style: TextStyle(
                        color: Color.fromRGBO(239, 132, 125, 1), fontSize: 20)),
              ),
            ]),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 10, 0),
                child: ElevatedButton.icon(
                    icon: Icon(Icons.arrow_right_alt),
                    label: Text("Next"),
                    onPressed: () {
                      addPost();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Posted()),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))))
          ],
        ),
      ),
    );
  }

  void _onPressed(uid) {
    FirebaseFirestore.instance.collection('posts').doc(uid).set(
        {"User Id": FieldValue.arrayUnion([])},
        SetOptions(merge: true)).then((_) {
      print("success!");
    });
  }
}
