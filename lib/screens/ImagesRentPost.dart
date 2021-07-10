import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kiraay/screens/MyAccount.dart';
import 'package:kiraay/screens/PendingItems.dart';
import 'package:kiraay/screens/RentingNewPost.dart';
import 'package:kiraay/screens/loginpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagesRentNew extends StatefulWidget {
  @override
  _ImagesRentNewState createState() => _ImagesRentNewState();
}

class _ImagesRentNewState extends State<ImagesRentNew> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color.fromRGBO(239, 132, 125, 1), Colors.greenAccent],
  ).createShader(Rect.fromLTWH(165.0, 200.0, 125.0, 200.0));

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
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
        body: Column(children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 100, 0, 30),
            child: Text("Insert Images:",
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
              child: Row(
                  children: [ImageProfile(), ImageProfile(), ImageProfile()])),
          Padding(
              padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
              child: Row(
                  children: [ImageProfile(), ImageProfile(), ImageProfile()]))
        ]));
  }

  Widget ImageProfile() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Stack(children: [
          CircleAvatar(radius: 60, backgroundColor: Colors.white
              // backgroundImage: _imageFile
              //== null ? AssetImage("assets/icons/add.png") : FileImage(File(_imageFile.path)),
              ),
          Positioned(
              bottom: 20,
              right: 20,
              child: InkWell(
                child: Icon(Icons.camera_alt, color: Colors.teal, size: 38),
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomField()));
                },
              ))
        ]));
  }

  Widget bottomField() {
    return Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          Text(
            "Choose Image:",
            style: TextStyle(fontSize: 20),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                child: Text("Take Photo"),
              ),
              TextButton(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                child: Text("Choose From Gallery"),
              )
            ],
          )
        ]));
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}
