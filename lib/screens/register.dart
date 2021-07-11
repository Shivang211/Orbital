// @dart=2.9
// import 'package:flutter_firebase_login/Screens/Home/homepage.dart';
// import 'package:flutter_firebase_login/Screens/Login2/LoginScreen.dart';
// import 'package:flutter_firebase_login/net/firebase.dart';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_firebase_login/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiraay/screens/Login.dart';
import 'package:kiraay/screens/verify.dart';

import 'mainpage.dart';

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
  static var userUid;
  static var telegramId;
}

class _RegisterViewState extends State<Register> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // void addUser() {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User currentUser = auth.currentUser;
  //   var userUid = currentUser.uid;
  //   Register.userUid = userUid;

  //   var collection = FirebaseFirestore.instance.collection('users');
  //   collection
  //       .doc('$userUid') // <-- Document ID
  //       .set({'email Id': _email, 'telegram id': _telegramId}) // <-- Your data
  //       .then((_) => print('Added: $userUid'))
  //       .catchError((error) => print('Add failed: $error'));
  // }

  static String _email;
  static String _password;

  var _passwordRepeat;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  TextEditingController _nusnetIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(239, 132, 125, 1),
            ),
          ),
          hintText: "Please use legitimate email id for verification email",
          labelText: "Email",
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          _email = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Email Id';
          }
          return null;
        });

    final passwordField = TextFormField(
        obscureText: true,
        controller: _passwordController,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.greenAccent,
            ),
          ),
          hintText: "Password",
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          _password = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        });

    final repasswordField = TextFormField(
        obscureText: true,
        controller: _repasswordController,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(239, 132, 125, 1),
            ),
          ),
          hintText: "Password",
          labelText: "Confirm Password",
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          _passwordRepeat = value;
        },
        validator: (value) {
          if (_password != value) {
            return 'Passwords do not match';
          }
          return null;
        });
    final nusnetIdField = TextFormField(
        controller: _nusnetIdController,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.grey,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.greenAccent,
            ),
          ),
          labelText: "Telegram ID",
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          hintText: ("Telegram Id"),
          hintStyle: TextStyle(
            color: Colors.grey,
          ),
        ),
        onChanged: (value) {
          Register.telegramId = value;
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your Telegram Id';
          }
          return null;
        });

    final fields = Padding(
      padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
          repasswordField,
          nusnetIdField,
        ],
      ),
    );

    final registerButton = Align(
        //padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: 120,
          child: SizedBox(
            width: 70,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: Text(
                  "Sign up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // TODO submit

                    try {
                      await Firebase.initializeApp();
                      UserCredential user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      User updateUser = FirebaseAuth.instance.currentUser;
                      Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => VerifyScreen()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  }
                }),
          ),
        ));

    final bottom = Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.fromLTRB(90, 100, 0, 0),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Already have an account?",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              ),
              MaterialButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed(AppRoutes.authLogin);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => Login()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Text(
                    "Login",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
        // backgroundColor: Color(0xff8c52ff),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              "Kiraay",
              textAlign: TextAlign.center,
              style: TextStyle(
                  //r,
                  fontSize: 30,
                  foreground: Paint()..shader = linearGradient,
                  fontFamily: 'Helvetica'),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(children: [
            Positioned.fill(
              child: Image(
                image: AssetImage("assets/icons/white2.png"),
                fit: BoxFit.contain,
              ),
            ),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                fields,
                const SizedBox(height: 8.0),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 30),
                  child: bottom,
                ),
              ],
            ),
          ]),
        ));
  }
}
