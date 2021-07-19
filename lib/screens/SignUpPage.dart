import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/mainpage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
  static var userUid;
}

class _SignUpState extends State<SignUp> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? currentUser = auth.currentUser;
    var userUid = currentUser!.uid;
    SignUp.userUid = userUid;

    var collection = FirebaseFirestore.instance.collection('users');
    return collection
        .doc('$userUid') // <-- Document ID
        .set({'email Id': _email, 'telegram id': _telegramId}) // <-- Your data
        .then((_) => print('Added: $userUid'))
        .catchError((error) => print('Add failed: $error'));
  }

  static late String _email;
  static late String _password;
  static late String _telegramId;
  var _passwordRepeat;

  Future<void> _createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Colors.white10,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), // here the desired height
          child: AppBar(
            //leadingWidth: 15, // <-- Use this

            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              "KIRAAY",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 28, foreground: Paint()..shader = linearGradient),
            ),
          ),
        ),
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email Id',
                            labelStyle: TextStyle(color: Colors.white)),
                        onChanged: (value) {
                          _email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Email Id';
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white)),
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Confirm password',
                            labelStyle: TextStyle(color: Colors.white)),
                        onChanged: (value) {
                          _passwordRepeat = value;
                        },
                        validator: (value) {
                          if (_password != value) {
                            return 'Passwords do not match';
                          }
                          return null;
                        }),
                    SizedBox(height: 30),
                    TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Telegram id',
                            labelStyle: TextStyle(color: Colors.white)),
                        onChanged: (value) {
                          _telegramId = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Telegram Id';
                          }
                          return null;
                        }),
                    Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // TODO submit
                                _createUser();
                                addUser();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Mainpage()),
                                );
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) =>
                                //       _buildPopupDialog(context),
                                // );
                              }
                            },
                            child: Text("Register"),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )))))
                  ],
                ))));
  }

  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Account Created!'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Login Now"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Loginpage()),
            );
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
