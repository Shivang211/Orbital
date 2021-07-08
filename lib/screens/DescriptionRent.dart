import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/ConfirmPost.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/RentingNewPost.dart';
import 'package:kiraay/screens/loginpage.dart';

import 'ImagesRentPost.dart';

class DescriptionRent extends StatefulWidget {
  @override
  _DescriptionRentState createState() => _DescriptionRentState();
  static var description;
}

class _DescriptionRentState extends State<DescriptionRent> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              "Creating Post",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, foreground: Paint()..shader = linearGradient),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(children: [
            Positioned.fill(
              child: Image(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 200, 250, 0),
                    child: Text(
                      " Enter Description:",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )),
                Container(
                  width: double.infinity,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText:
                                'Kindly write a detailed description about the item',
                            hintStyle: TextStyle(fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: Colors.white,
                            filled: true),
                        maxLength: 200,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Text is empty';
                          }
                          DescriptionRent.description = text;
                          return null;
                        },
                      )),
                ),
                ElevatedButton.icon(
                    icon: Icon(Icons.arrow_right_alt),
                    label: Text("Next"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO submit
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmPost()),
                        );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))))
              ],
            ),
          ]),
        ));
  }
}
