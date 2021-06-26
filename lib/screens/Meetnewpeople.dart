import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/mainpage.dart';

import 'CreatenewPost.dart';

class MeetNew extends StatefulWidget {
  @override
  _MeetNewState createState() => _MeetNewState();
}

class _MeetNewState extends State<MeetNew> {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "Meet New People",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 23, foreground: Paint()..shader = linearGradient),
          ),
        ),
      ),
      body: Center(
          child: Column(children: [
        //Padding(
        //padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        // child: SizedBox(
        //   width: 150.0,
        //   height: 35.0,
        //   child: ElevatedButton(
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => Homepage()),
        //         );
        //       },
        //       child: Text("Rent In"),
        //       style: ButtonStyle(
        //           backgroundColor: MaterialStateProperty.all(Colors.blue),
        //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //               RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(18.0),
        //           )))),
        // ),

        // Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0), child: SizedBox(
        //   width: 120.0,
        //   height: 35.0,
        // child:
        // ElevatedButton(onPressed: (){}, child: Text("Create New Post"), style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.grey),
        //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //         RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(18.0),
        //         )))))),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 600, 0, 0),
            child: Row(children: [
              IconButton(
                icon: Icon(Icons.person_pin, size: 45, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Homepage()),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(45, 10, 0, 0),
                child: SizedBox(
                  width: 200.0,
                  height: 35.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Mainpage()),
                        );
                      },
                      child: Text("Rent In"),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )))),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(27, 10, 0, 0),
                child: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateNewPost()),
                    );
                  },
                ),
              )
            ]))
      ])),
    );
  }
}
