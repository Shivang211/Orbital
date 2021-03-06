// @dart=2.9
import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/Login.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/MyPostLend.dart';
import 'package:kiraay/screens/MyPostsRent.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:kiraay/screens/register.dart';

import 'Deleted.dart';
import 'SignUpPage.dart';
import 'mainpage.dart';

class MyMatches extends StatefulWidget {
  @override
  _MyMatchesState createState() => _MyMatchesState();
}

class _MyMatchesState extends State<MyMatches> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String name = "";

  static String id;
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    final List _children = [MyRentposts(), MyLendposts()];

    return Scaffold(
      backgroundColor: Colors.white,
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex, //New
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        // new
        // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.add_shopping_cart_rounded),
            label: 'To Borrow',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.local_grocery_store),
            label: 'To Lend',
          ),
        ],
      ),
    );
  }
}


  

//         body: Stack(children: [
//           Positioned.fill(
//             child: Image(
//               image: AssetImage("assets/icons/white5.png"),
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 38, top: 20.0),
//                 child: Icon(
//                   Icons.post_add_rounded,
//                   color: Color.fromRGBO(239, 132, 125, 1),
//                   size: 150,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 13, bottom: 50.0),
//                 child: Text("Posts created by you:",
//                     textAlign: TextAlign.left,
//                     style:
//                         TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
//               ),
//               Expanded(
//                 child: StreamBuilder<QuerySnapshot>(
//                   stream: (name != "" && name != null)
//                       ? FirebaseFirestore.instance
//                           .collection('posts')
//                           .where("caseSearch", arrayContains: name)
//                           .where('rental status', isEqualTo: false)
//                           .where("owner id", isEqualTo: user!.email)
//                           .snapshots()
//                       : FirebaseFirestore.instance
//                           .collection("posts")
//                           .where('rental status', isEqualTo: false)
//                           .where("owner id", isEqualTo: user!.email)
//                           .snapshots(),
//                   builder: (context, snapshot) {
//                     return (snapshot.connectionState == ConnectionState.waiting)
//                         ? Center(child: CircularProgressIndicator())
//                         : GridView.builder(
//                             shrinkWrap: true,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               crossAxisSpacing: 5.0,
//                               mainAxisSpacing: 25,
//                             ),
//                             itemCount: snapshot.data!.docs.length,
//                             itemBuilder: (context, index) {
//                               id = snapshot.data!.docs[index].id;
//                               DocumentSnapshot data =
//                                   snapshot.data!.docs[index];
//                               if (data['rental status'] == true) {
//                                 return Column(children: [
//                                   Card(
//                                     elevation: 1,
//                                     shape: RoundedRectangleBorder(
//                                       side: BorderSide(
//                                           color: Colors.white60, width: 1),
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     color: Colors.white,
//                                     child: MaterialButton(
//                                       onPressed: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) =>
//                                               _buildPopup(context, data),
//                                         );
//                                       },
//                                       child: SizedBox(
//                                         //width: double.infinity,
//                                         height: 120,
//                                         child: Column(
//                                             // crossAxisAlignment:
//                                             //     CrossAxisAlignment.center,
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         54, 10, 0, 20),
//                                                 child: Row(children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 2),
//                                                     child: Icon(Icons.thumb_up,
//                                                         color: Colors.grey),
//                                                   ),
//                                                   Text(
//                                                       "${(data["User Id"].length)}")
//                                                 ]),
//                                               ),
//                                               Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Text(
//                                                     "${data['item_name']}",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontWeight:
//                                                             FontWeight.w300,
//                                                         fontSize: 20)),
//                                               ),
//                                             ]),
//                                       ),
//                                     ),
//                                   )
//                                 ]);
//                               } else {
//                                 return Column(children: [
//                                   Card(
//                                     elevation: 10,
//                                     shape: RoundedRectangleBorder(
//                                       side: BorderSide(
//                                           color: Colors.greenAccent, width: 1),
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     color: Colors.white,
//                                     child: MaterialButton(
//                                       onPressed: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) =>
//                                               _buildPopupDialog(context, data),
//                                         );
//                                       },
//                                       child: SizedBox(
//                                         //width: double.infinity,
//                                         height: 120,

//                                         child: Column(
//                                             // crossAxisAlignment:
//                                             //     CrossAxisAlignment.center,
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.center,
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.fromLTRB(
//                                                         54, 10, 0, 20),
//                                                 child: Row(children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 2),
//                                                     child: Icon(Icons.thumb_up,
//                                                         color: Colors.grey),
//                                                   ),
//                                                   Text(
//                                                       "${(data["User Id"].length)}")
//                                                 ]),
//                                               ),
//                                               Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Text(
//                                                     "${data['item_name']}",
//                                                     style: TextStyle(
//                                                         color: Colors.black,
//                                                         fontWeight:
//                                                             FontWeight.w300,
//                                                         fontSize: 20)),
//                                               ),
//                                             ]),
//                                       ),
//                                     ),
//                                   )
//                                 ]);
//                               }
//                             },
//                           );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ]));
//   }

//   Widget _buildPopupDialog(BuildContext context, DocumentSnapshot data) {
//     var teleId = data['User Id'].toString();

//     return new AlertDialog(
//       title: Text("People who have liked your post"),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(data['User Id'].toString()),
//           Text("Number of likes : ${(data["User Id"].length)}")
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) =>
//                     _buildPopupPostInfo(context, data),
//               );
//             },
//             child: Text("Post Info")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) =>
//                     _buildPopupLendInfo(context, data),
//               );
//             },
//             child: Text("Lend")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Close"))
//       ],
//     );
//   }

//   Widget _buildPopupLendInfo(BuildContext context, DocumentSnapshot data) {
//     var teleId;

//     return new AlertDialog(
//       title: Text("Lend Post"),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           TextFormField(
//             style: TextStyle(
//               color: Colors.black,
//             ),
//             cursorColor: Colors.grey,
//             decoration: InputDecoration(
//               prefixIcon: Icon(Icons.edit),
//               // enabledBorder: OutlineInputBorder(
//               //   borderSide: BorderSide(
//               //     color: Colors.black,
//               //   ),
//               //   borderRadius: BorderRadius.circular(30.0),
//               // ),
//               fillColor: Colors.white,
//               // filled: true,
//               hintText: "Telegram Id",
//               labelText: "Enter your telegram id",
//               labelStyle: TextStyle(
//                 color: Colors.grey,
//               ),
//               hintStyle: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//             onChanged: (val) {
//               setState(() {
//                 teleId = val;
//               });
//             },
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Text(data['User Id'].toString()),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) =>
//                     _buildPopupPostInfo(context, data),
//               );
//             },
//             child: Text("Post Info")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Lend")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Close"))
//       ],
//     );
//   }

//   Widget _buildPopupPostInfo(BuildContext context, DocumentSnapshot data) {
//     List list = data['User Id'];
//     return new AlertDialog(
//       title: Text(data['item_name']),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text("${data['description']}"),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) =>
//                     _buildPopupDialog(context, data),
//               );
//             },
//             child: Text("Likes Info")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Edit Post")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor:
//                     MaterialStateProperty.all(Color.fromRGBO(239, 132, 125, 1)),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Close"))
//       ],
//     );
//   }

//   Widget _buildPopup(BuildContext context, DocumentSnapshot data) {
//     return new AlertDialog(
//       title: Text(data['item_name']),
//       content: new Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//               "Sorry, this item is unavailable right now. Check later for updates"),
//         ],
//       ),
//       actions: <Widget>[
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.black),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               var id = data['owner id'] + data['item_name'];
//               FirebaseFirestore.instance
//                   .collection('posts')
//                   .doc('$id') // <-- Doc ID where data should be updated.
//                   .update({
//                 "User Id": FieldValue.arrayRemove(["${user!.email}"])
//               });
//               Navigator.of(context).pop();
//             },
//             child: Text("Unlike")),
//         ElevatedButton(
//             style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.red),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(18.0),
//                 ))),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Close"))
//       ],
//     );
//   }
// }
