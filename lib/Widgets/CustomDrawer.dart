import 'package:blood_donation/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../Screens/Register.dart';

class CustomDrawer extends StatefulWidget {
  final Auth auth;
  CustomDrawer({@required this.auth});
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Drawer(
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
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: RegistrationScreen(auth: widget.auth),
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
              SizedBox(
                height: totalHeight * 0.2,
              ),
              GestureDetector(
                onTap: () {
                  _signOut();
                },
                child: Container(
                  height: totalHeight * 0.06,
                  width: totalWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      "Logout",
                      style: GoogleFonts.meriendaOne(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      textScaleFactor: 1.1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
