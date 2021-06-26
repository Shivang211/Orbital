import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/loginpage.dart';

import 'DescriptionRent.dart';

class CreateNewRent extends StatefulWidget {
  @override
  _CreateNewRentState createState() => _CreateNewRentState();
  static var item_name;
}

class _CreateNewRentState extends State<CreateNewRent> {
  final _formKey = GlobalKey<FormState>();
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          //leadingWidth: 15, // <-- Use this

          backgroundColor: Colors.white10,
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
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(0, 200, 250, 0),
                child: Text(
                  " Enter Item name:",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Max 50 characters',
                      hintStyle: TextStyle(fontSize: 15),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fillColor: Colors.white,
                      filled: true),
                  maxLength: 50,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Text is empty';
                    }
                    CreateNewRent.item_name = text;
                    return null;
                  },
                )),
            ElevatedButton.icon(
                icon: Icon(Icons.arrow_right_alt),
                label: Text("Next"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO submit
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DescriptionRent()),
                    );
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))))
          ],
        ),
      ),
    );
  }
}
//         Center(
//             child: Column(children: [
//           Padding(
//               padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
//               child: Text(
//                 " Enter Item name:",
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               )),
//           Padding(
//             padding: EdgeInsets.fromLTRB(38, 30, 20, 0),
//             child: Container(
//               height: 80,
//               child: TextFormField(
//                   validator: (text) {
//                     if (text == null || text.isEmpty) {
//                       return 'Text is empty';
//                     }
//                     return null;
//                   },
//                   maxLength: 20,
//                   onChanged: (value) {},
//                   decoration: InputDecoration(
//                       hintText: "Max 20 characters",
//                       hintStyle: TextStyle(fontSize: 15),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.white,
//                         ),
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       fillColor: Colors.white,
//                       filled: true)),
//             ),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 if (_formKey.currentState.validate()) {
//                   // TODO submit
//                 }
//               },
//               child: Text("Next"),
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.blue),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                   ))))
//         ])));
//   }
// }
