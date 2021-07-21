// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_firebase_login/Screens/Home/homepage.dart';
// import 'package:flutter_firebase_login/Screens/Register/RegisterScreen.dart';
// import 'package:flutter_firebase_login/theme/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/register.dart';
// import 'package:flutter_firebase_login/widgets/custom_alert_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'MyAccount.dart';
import 'SignUpPage.dart';
import 'Widgets/custom.dart';

class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
  static String useruid;
}

String errorMessage;

class _LoginViewState extends State<Login> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    void showAlertDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _emailControllerField =
                TextEditingController();
            return CustomAlertDialog(
              content: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 4.0,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text("Insert Reset Email:"),
                    TextField(
                      style: TextStyle(color: Colors.black),
                      controller: _emailControllerField,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.blue,
                        child: MaterialButton(
                          minWidth: mq.size.width / 2,
                          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                          child: Text(
                            "Send Reset Email",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              FirebaseAuth.instance.sendPasswordResetEmail(
                                  email: _emailControllerField.text);
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }

    final emailField = TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter an email id';
        }
        return null;
      },
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(239, 132, 125, 1),
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: "Email Id",
        labelText: "Enter Email Id",
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          obscureText: true,
          controller: _passwordController,
          style: TextStyle(
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.greenAccent,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: "Password",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
            labelText: "Password",
            labelStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: passwordField,
          )
        ],
      ),
    );

    final loginButton = Padding(
        padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(10),
              backgroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          child: SizedBox(
            width: 90,
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Colors.white
                  //fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              try {
                //await Firebase.initializeApp();
                // FirebaseAuth.
                UserCredential user =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                setState(() {
                  errorMessage = null;
                });

                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Homepage()));
              } catch (e) {
                print(e);
                setState(() {
                  errorMessage = e.message;
                });
              }
            }
          },
        ));

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(30.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Not a member?",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            MaterialButton(
              onPressed: () {
                // Navigator.of(context).pushNamed(AppRoutes.authRegister);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => Register()));
              },
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ],
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: Center(
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
                    showAlert(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 70, 0, 150),
                      child: Text("Kiraay",
                          style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w500,
                              foreground: Paint()..shader = linearGradient,
                              fontFamily: 'Helvetica')),
                    ),
                    fields,
                    Padding(padding: EdgeInsets.only(top: 20)),
                    bottom,
                  ],
                ),
              ]),
            )));
  }

  Widget showAlert() {
    if (errorMessage != null) {
      return Container(
          color: Colors.greenAccent,
          width: double.infinity,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(children: [
              Icon(Icons.error_outline_outlined),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text(
                    "$errorMessage",
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      errorMessage = null;
                    });
                  },
                  icon: Icon(Icons.close))
            ]),
          ));
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }
}
