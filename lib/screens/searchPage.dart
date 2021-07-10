import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kiraay/screens/mainpage.dart';
import 'package:kiraay/screens/register.dart';

import 'Login.dart';

class CloudFirestoreSearch extends StatefulWidget {
  @override
  _CloudFirestoreSearchState createState() => _CloudFirestoreSearchState();
}

class _CloudFirestoreSearchState extends State<CloudFirestoreSearch> {
  String name = "";

  // var userId;
  // String getId() {
  //   if (Register.userUid != null) {
  //     userId = Register.userUid;
  //     return userId;
  //   } else {
  //     userId = Login.useruid;
  //     return userId;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Mainpage()),
            );
          },
        ),
        title: Card(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: (name != "" && name != null)
            ? FirebaseFirestore.instance
                .collection('posts')
                .where("caseSearch", arrayContains: name)
                .where("rental status", isEqualTo: false)
                //.where("owner id", isNotEqualTo: getId())
                .snapshots()
            : FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return Column(children: [
                      Text("Click on the Item for more info"),
                      Card(
                        child: Row(
                          children: <Widget>[
                            MaterialButton(
                              child: Text(
                                data['item_name'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(context, data),
                                );
                              },
                            ),
                            SizedBox(width: 25, height: 100),
                            Text(
                              data['description'],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      )
                    ]);
                  },
                );
        },
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context, DocumentSnapshot data) {
    return new AlertDialog(
      title: Text(data['item_name']),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(data['description']),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.lightBlueAccent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"))
      ],
    );
  }
}
