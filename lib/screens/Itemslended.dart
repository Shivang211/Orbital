import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/loginpage.dart';

class ItemsLended extends StatefulWidget {
  @override
  _ItemsLendedState createState() => _ItemsLendedState();
}

class _ItemsLendedState extends State<ItemsLended> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Items Lent",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, foreground: Paint()..shader = linearGradient),
          ),
        ),
      ),
    );
  }
}
