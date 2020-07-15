import 'package:blood_donation/Screens/HomePage.dart';
import 'package:blood_donation/Services/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class RegistrationScreen extends StatefulWidget {
  final Auth auth;
  RegistrationScreen({@required this.auth});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name;
  String _chosenBloodGroup;
  void getData() async {
    User user = await widget.auth.currentUser();
    String uid = user.uid;

    DocumentSnapshot snap =
        await Firestore.instance.collection('Users').document(uid).get();

    setState(() {
      name = snap.data['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
        body: Container(
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
              Row(children: [
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
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
