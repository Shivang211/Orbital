import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/SignUpPage.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
  static var userUid;
}

class _LoginpageState extends State<Loginpage> {
  late String _email;
  late String _password;

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

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? currentUser = auth.currentUser;
      Loginpage.userUid = currentUser!.uid;
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
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              "KIRAAY",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  foreground: Paint()..shader = linearGradient,
                  fontFamily: 'Helvetica'),
            ),
          ),
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Container(
                  height: 50,
                  child: TextFormField(
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Email Id",
                        hintStyle: TextStyle(fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Colors.white,
                        filled: true),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 5, 16, 0),
                child: Container(
                  height: 50,
                  child: TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(fontSize: 15),
                          fillColor: Colors.white,
                          filled: true)),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 40),
                    child: ElevatedButton(
                        onPressed: _login,
                        child: Text("Login"),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        )))))
              ]),
              Align(
                alignment: Alignment.bottomCenter,
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(100, 40, 50, 20),
                  child: Row(
                    children: [
                      Text(
                        "Not Registered Yet?",
                        style: TextStyle(color: Colors.white),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            child: Text("Sign Up"),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                )))),
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 20, 10),
                  child: SignInButton(
                    Buttons.Google,
                    onPressed: () {},
                  )),
              Padding(
                  padding: EdgeInsets.fromLTRB(35, 0, 20, 0),
                  child: SignInButton(
                    Buttons.Facebook,
                    onPressed: () {},
                  ))
            ],
          ),
        )));
  }
}
