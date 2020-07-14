import 'package:blood_donation/Animations/FadeAnimation.dart';
import 'package:blood_donation/Screens/Loading.dart';
import 'package:blood_donation/Services/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../Screens/CreateAccount.dart';
import '../Services/Auth.dart';

class SignIn extends StatefulWidget {
  // authbase instance
  final AuthBase auth;
  SignIn({@required this.auth});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // value controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // signin  with mail method

  Future<void> _signInWithEmail(String mail, String password) async {
    try {
      dynamic result = await widget.auth.signInWithEmail(mail, password);
      if (result == null) {
        setState(() {
          loading = false;
        });
        // alert if info is invalid
        Alert(
          context: context,
          type: AlertType.error,
          title: "Error !!",
          desc: "User not found. Check credentials",
          buttons: [
            DialogButton(
              color: Colors.pinkAccent,
              child: Text(
                "Okay",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
      } else {
        // goes to landing page after succesful
        Navigator.push(
          context,
          MaterialPageRoute(
            // here landing page takes user to homepage
            builder: (context) => LandingPage(
              auth: widget.auth,
              email: mail.toUpperCase(),
            ),
          ),
        );
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      print(e);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Error !!",
        desc: "User not found. Check credentials !",
        buttons: [
          DialogButton(
            color: Colors.pinkAccent,
            child: Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

//  Future<void> _signInWithGoogle() async {
//     try {
//       await widget.auth.signInWithGoogle();
//     } catch (e) {
//       print("Error in google sign in \n $e");
//     }
//   }

  // Future<void> _signInWithFacebook() async {
  //   try {
  //     await widget.auth.signInWithFacebook();
  //   } catch (e) {
  //     print("Error in Facebook login \n $e");
  //   }
  // }
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    // text controllers

    // // firebase auth instance
    // final AuthService _auth = AuthService();

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        // main body

        // TODO: this is just core functionality. Have to change UI later
        body: loading == true
            ? Loading()
            : SingleChildScrollView(
                child: Container(
                  height: totalHeight * 1,
                  width: totalWidth * 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(239, 44, 120, 1),
                        Color.fromRGBO(237, 66, 101, 1),
                        Color.fromRGBO(239, 79, 79, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: totalHeight * 0.18,
                      ),
                      // sign in button
                      FadeIn(
                        0.5,
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.05,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Welcome",
                              style: GoogleFonts.meriendaOne(
                                color: Colors.white,
                                fontSize: totalHeight * 0.045,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeIn(
                        0.9,
                        Padding(
                          padding: EdgeInsets.only(
                            left: totalWidth * 0.08,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Give the gift of life !",
                              style: GoogleFonts.meriendaOne(
                                color: Colors.grey[200],
                                fontSize: totalHeight * 0.023,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: totalHeight * 0.035,
                      ),
                      // textfiled for email
                      FadeIn(
                        1.3,
                        Container(
                          width: totalWidth * 0.9,
                          child: TextField(
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                hintText: "Enter your email",
                                hintStyle: TextStyle(
                                  color: Colors.grey[200],
                                )),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: totalHeight * 0.01,
                      ),
                      // textfield for password
                      FadeIn(
                        1.7,
                        Container(
                          width: totalWidth * 0.9,
                          child: TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                color: Colors.grey[200],
                              ),
                            ),
                            controller: passwordController,
                            obscureText: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: totalHeight * 0.05,
                      ),
                      FadeIn(
                        2.1,
                        Center(
                          // sign in button
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                loading = true;
                              });
                              String mail = emailController.value.text;
                              String password = passwordController.value.text;

                              _signInWithEmail(mail, password);

                              emailController.clear();
                              passwordController.clear();
                            },
                            child: Container(
                              // container for button
                              height: totalHeight * 0.07,
                              width: totalWidth * 0.7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  // button text
                                  "Sign in",
                                  style: GoogleFonts.meriendaOne(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: totalHeight * 0.04,
                      ),
                      // bottom section
                      Row(
                        children: [
                          SizedBox(
                            width: totalWidth * 0.2,
                          ),
                          FadeIn(
                            2.5,
                            Text(
                              "Don't have an account ?  ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: totalWidth * 0.04,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateAccount(
                                    auth: widget.auth,
                                  ),
                                ),
                              );
                            },
                            child: FadeIn(
                              3.0,
                              Text(
                                "Create One",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: totalWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
