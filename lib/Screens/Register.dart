import 'dart:io';

import 'package:blood_donation/Animations/FadeAnimation.dart';
import 'package:blood_donation/Animations/RegistrationAnimation.dart';
import 'package:blood_donation/Screens/HomePage.dart';
import 'package:blood_donation/Screens/Loading.dart';
import 'package:blood_donation/Services/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class RegistrationScreen extends StatefulWidget {
  final Auth auth;
  RegistrationScreen({@required this.auth});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // file for image
  File _image;
  // image picker object
  final picker = ImagePicker();
  // storage bucket
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://blood-donation-f8f08.appspot.com");

  // get image from gallery
  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    setState(
      () {
        _image = File(pickedFile.path);
      },
    );
  }

  bool _isLoading = false;
  // upload image and registers user
  void registerUser() async {
    User _user = await widget.auth.currentUser();
    String _uid = _user.uid;
    print("UID IS ******* $_uid");
    setState(() {
      _isLoading = true;
    });
    StorageTaskSnapshot snapshot =
        await _storage.ref().child("$_uid").putFile(_image).onComplete;
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    await Firestore.instance.collection("Users").document(_uid).setData({
      'isRegistered': true,
      "profilePic": downloadUrl,
      "bloodGroup": _chosenBloodGroup,
      "totalDonations": _chosenDonations,
      "lastDonation": _chosenDate,
      "location": _chosenThana,
      "name": name,
    });

    setState(() {
      _isLoading = false;
    });
  }

  String name;
  String uid;
  String _chosenBloodGroup;
  int _chosenDonations = 0;
  String _chosenThana;
  bool isRegistered;
  void getData() async {
    setState(() {
      _isLoading = true;
    });
    User user = await widget.auth.currentUser();
    String _uid = user.uid;

    DocumentSnapshot snap =
        await Firestore.instance.collection('Users').document(_uid).get();

    setState(() {
      name = snap.data['name'];
      _uid = uid;
      isRegistered = snap.data['isRegistered'];
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  // method for showing customized calender
  DateTime _chosenDate;
  void showCalender() async {
    DateTime _newDateTime = await showRoundedDatePicker(
      context: context,
      theme: ThemeData(primarySwatch: Colors.pink),
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime.now(),
      borderRadius: 16,
    );
    setState(() {
      _chosenDate = _newDateTime;
    });
  }

  // drop down for blood group
  Widget myDropDown(List<String> items) {
    return DropdownButton<String>(
      dropdownColor: Color.fromRGBO(239, 44, 120, 1),
      value: _chosenBloodGroup,
      hint: Text("Select One"),
      icon: Icon(Icons.arrow_downward),
      iconSize: 20.0, // can be changed, default: 24.0
      iconEnabledColor: Color.fromRGBO(239, 44, 120, 1),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              style: GoogleFonts.meriendaOne(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          _chosenBloodGroup = value;
        });
      },
    );
  }

  //drop down for number of donations
  Widget myIntDropDown(List<int> items) {
    return DropdownButton<int>(
      dropdownColor: Color.fromRGBO(239, 44, 120, 1),
      value: _chosenDonations,
      hint: Text("Select One"),
      icon: Icon(Icons.arrow_downward),
      iconSize: 20.0, // can be changed, default: 24.0
      iconEnabledColor: Color.fromRGBO(239, 44, 120, 1),
      items: items.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Center(
            child: Text(
              value.toString(),
              style: GoogleFonts.meriendaOne(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (int value) {
        setState(() {
          _chosenDonations = value;
        });
      },
    );
  }

  // dropdown for thana
  Widget thanaDropDown(List<String> items) {
    return DropdownButton<String>(
      dropdownColor: Color.fromRGBO(239, 44, 120, 1),
      value: _chosenThana,
      hint: Text("Select One"),
      icon: Icon(Icons.arrow_downward),
      iconSize: 20.0, // can be changed, default: 24.0
      iconEnabledColor: Color.fromRGBO(239, 44, 120, 1),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              style: GoogleFonts.meriendaOne(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (String value) {
        setState(() {
          _chosenThana = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color.fromRGBO(239, 44, 120, 1),
                  Color.fromRGBO(237, 66, 101, 1),
                  Color.fromRGBO(239, 79, 79, 1),
                ],
              ),
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: HomePage(auth: widget.auth),
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(
              "Register",
              style: GoogleFonts.meriendaOne(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: _isLoading == true
            ? Loading()
            : isRegistered == true
                ? RegisterAnimation()
                : SingleChildScrollView(
                    child: Container(
                      height: totalHeight * 1,
                      width: totalWidth * 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: totalHeight * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: totalWidth * 0.04,
                            ),
                            child: Text(
                              "Name :",
                              style: GoogleFonts.meriendaOne(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: totalHeight * 0.004,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: totalWidth * 0.08,
                            ),
                            child: name == null
                                ? Text(
                                    "Fetching Data...",
                                    style: GoogleFonts.meriendaOne(
                                      color: Color.fromRGBO(239, 44, 120, 1),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Text(
                                    name,
                                    style: GoogleFonts.meriendaOne(
                                      color: Color.fromRGBO(239, 44, 120, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: totalWidth * 0.04,
                            ),
                            child: Text(
                              "Select Profile Picture :",
                              style: GoogleFonts.meriendaOne(
                                color: Color.fromRGBO(239, 44, 120, 1),
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          Center(
                            child: _image == null
                                ? ClipOval(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 220.0,
                                          width: 220.0,
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/avatar.png'),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: totalHeight * 0.0,
                                          child: Opacity(
                                            opacity: 0.9,
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 40.0,
                                                  width: 220.0,
                                                  color: Color.fromRGBO(
                                                      239, 44, 120, 1),
                                                ),
                                                Positioned(
                                                  bottom: 3,
                                                  left: 95,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      getImage();
                                                    },
                                                    child: Icon(
                                                      Icons.camera,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : ClipOval(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 220.0,
                                          width: 220.0,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Image.file(_image),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: totalHeight * 0.0,
                                          child: Opacity(
                                            opacity: 0.9,
                                            child: Stack(
                                              children: <Widget>[
                                                Container(
                                                  height: 40.0,
                                                  width: 220.0,
                                                  color: Color.fromRGBO(
                                                      239, 44, 120, 1),
                                                ),
                                                Positioned(
                                                  bottom: 3,
                                                  left: 95,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      getImage();
                                                    },
                                                    child: Icon(
                                                      Icons.camera,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: totalWidth * 0.04,
                                ),
                                child: Text(
                                  "Blood Group :",
                                  style: GoogleFonts.meriendaOne(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: totalWidth * 0.02,
                              ),
                              myDropDown(
                                [
                                  'A+',
                                  'A-',
                                  'B+',
                                  'B-',
                                  'O+',
                                  'O-',
                                  'AB+',
                                  'AB-',
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: totalWidth * 0.04,
                                ),
                                child: Text(
                                  "Previous Donations :",
                                  style: GoogleFonts.meriendaOne(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: totalWidth * 0.02,
                              ),
                              myIntDropDown(
                                [
                                  0,
                                  1,
                                  2,
                                  3,
                                  4,
                                  5,
                                  6,
                                  7,
                                  8,
                                  9,
                                  10,
                                  11,
                                  12,
                                  13,
                                  14,
                                  15,
                                  16,
                                  17,
                                  18,
                                  19,
                                  20,
                                  21,
                                  22,
                                  23,
                                  24,
                                  25,
                                  26,
                                  27,
                                  28,
                                  29,
                                  30,
                                  31,
                                  32,
                                  33,
                                  34,
                                  35,
                                  36,
                                  37,
                                  38,
                                  39,
                                  40,
                                  41,
                                  42,
                                  43,
                                  44,
                                  45,
                                  46,
                                  47,
                                  48,
                                  49,
                                  50,
                                  51,
                                  52,
                                  53,
                                  54,
                                  55,
                                  56,
                                  57,
                                  58,
                                  59,
                                  60,
                                  61,
                                  62,
                                  63,
                                  64,
                                  65,
                                  66,
                                  67,
                                  68,
                                  69,
                                  70,
                                  71,
                                  72,
                                  73,
                                  74,
                                  75,
                                  76,
                                  77,
                                  78,
                                  79,
                                  80,
                                  81,
                                  82,
                                  83,
                                  84,
                                  85,
                                  86,
                                  87,
                                  88,
                                  89,
                                  90,
                                  91,
                                  92,
                                  93,
                                  94,
                                  95,
                                  96,
                                  97,
                                  98,
                                  99,
                                  100
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          _chosenDonations != 0
                              ? FadeIn(
                                  0.7,
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: totalWidth * 0.04,
                                        ),
                                        child: Text(
                                          "Last Donation Date :",
                                          style: GoogleFonts.meriendaOne(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: totalWidth * 0.03,
                                      ),
                                      _chosenDate == null
                                          ? GestureDetector(
                                              onTap: () {
                                                showCalender();
                                              },
                                              child: Icon(
                                                Icons.calendar_today,
                                                size: 30.0,
                                                color: Colors.pink,
                                              ),
                                            )
                                          : Text(
                                              "${_chosenDate.day}-${_chosenDate.month}-${_chosenDate.year}",
                                              style: GoogleFonts.meriendaOne(
                                                color: Colors.pink,
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  left: totalWidth * 0.04,
                                ),
                                child: Text(
                                  "Thana :",
                                  style: GoogleFonts.meriendaOne(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: totalWidth * 0.02,
                              ),
                              thanaDropDown([
                                'Sadar',
                                'Aditmari',
                                'Kaliganj',
                                'Hatibandha',
                                'Patgram'
                              ]),
                            ],
                          ),
                          SizedBox(
                            height: totalHeight * 0.02,
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                registerUser();
                              },
                              child: Container(
                                height: totalHeight * 0.07,
                                width: totalWidth * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(239, 44, 120, 1),
                                      Color.fromRGBO(237, 66, 101, 1),
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.meriendaOne(
                                      color: Colors.white,
                                      fontSize: totalHeight * 0.026,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
