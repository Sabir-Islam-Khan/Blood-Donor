import 'package:blood_donation/Screens/Register.dart';
import 'package:blood_donation/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final AuthBase auth;
  HomePage({@required this.auth});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // total height and width constrains
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
        ),
        endDrawer: Drawer(
          child: SafeArea(
            child: Container(
              height: totalHeight * 1,
              width: totalWidth * 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    Color.fromRGBO(239, 44, 120, 1),
                    Color.fromRGBO(237, 66, 101, 1),
                    Color.fromRGBO(239, 79, 79, 1),
                  ],
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: totalHeight * 0.02,
                  ),
                  Center(
                    child: Text(
                      "Menu",
                      style: GoogleFonts.meriendaOne(
                        fontSize: 24.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: totalHeight * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(
                            auth: widget.auth,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: totalWidth * 0.03,
                        ),
                        Image(
                          height: 45.0,
                          width: 45.0,
                          image: AssetImage('assets/images/donor.png'),
                        ),
                        SizedBox(
                          width: totalWidth * 0.02,
                        ),
                        Text(
                          "Register as a Donor",
                          style: GoogleFonts.meriendaOne(
                            fontSize: totalWidth * 0.05,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: totalHeight * 1,
            width: totalWidth * 1,
            color: Colors.grey[200],
            child: Center(
                child: Container(
              height: totalHeight * 0.2,
              width: totalWidth * 0.3,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {
                  _signOut();
                },
                child: Center(
                  child: Text("Logout"),
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
