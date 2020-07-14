import 'package:blood_donation/Screens/Loading.dart';
import 'package:blood_donation/Screens/Signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/Auth.dart';
import '../Services/LandingPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CreateAccount extends StatefulWidget {
  final AuthBase auth;

  CreateAccount({@required this.auth});
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  // value controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  bool isLoading = false;
  void createData(String name, String email) async {
    Auth _auth = Auth();

    User _user = await _auth.currentUser();

    await Firestore.instance.collection('Users').document(_user.uid).setData(
      {
        'name': name,
        'email': email,
        'isRegestered': false,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // toal height and width contrans
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        // appbar

        // main body

        // TODO: this is just core functionality. Have to change UI later
        body: isLoading == true
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
                        height: totalHeight * 0.15,
                      ),
                      // sign in button
                      Padding(
                        padding: EdgeInsets.only(
                          left: totalWidth * 0.06,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Join Us !",
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: totalHeight * 0.05,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: totalWidth * 0.08,
                          bottom: totalHeight * 0.03,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Make a difference !",
                            style: GoogleFonts.meriendaOne(
                              color: Colors.grey[200],
                              fontSize: totalHeight * 0.023,
                            ),
                          ),
                        ),
                      ),

                      // textfield for name
                      Container(
                        width: totalWidth * 0.9,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Enter your name",
                            hintStyle: TextStyle(
                              color: Colors.grey[200],
                            ),
                          ),
                          controller: nameController,
                        ),
                      ),
                      SizedBox(
                        height: totalHeight * 0.01,
                      ),
                      // textfiled for email
                      Container(
                        width: totalWidth * 0.9,
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.white,
                            )),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              color: Colors.grey[200],
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                        ),
                      ),

                      // textfield for password
                      Container(
                        width: totalWidth * 0.9,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintText: "Minuimum 6 digit password",
                            hintStyle: TextStyle(
                              color: Colors.grey[200],
                            ),
                          ),
                          controller: passwordController,
                        ),
                      ),
                      SizedBox(
                        height: totalHeight * 0.05,
                      ),
                      Center(
                        // sign up button
                        child: GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            print("Sign up button tapped !");
                            String mail = emailController.value.text;
                            String password = passwordController.value.text;

                            try {
                              dynamic result = await widget.auth
                                  .createAccountWithEmail(mail, password);
                              if (result == null) {
                                setState(() {
                                  isLoading = false;
                                });
                                // alert if info is invalid
                                Alert(
                                  context: context,
                                  type: AlertType.error,
                                  title: "Error !!",
                                  desc: "Info invalid. Check credentials !",
                                  buttons: [
                                    DialogButton(
                                      color: Colors.pinkAccent,
                                      child: Text(
                                        "Okay",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      width: 120,
                                    )
                                  ],
                                ).show();
                              } else {
                                // creates initial data on db when successful

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
                                createData(
                                  nameController.value.text,
                                  emailController.value.text,
                                );
                              }
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              print(e);
                              Alert(
                                context: context,
                                type: AlertType.error,
                                title: "Error !!",
                                desc: "Info invalid. Check credentials !",
                                buttons: [
                                  DialogButton(
                                    color: Colors.pinkAccent,
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                            emailController.clear();
                            passwordController.clear();
                            nameController.clear();
                          },
                          child: Container(
                            // container for the button
                            height: totalHeight * 0.07,
                            width: totalWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Center(
                              // button text
                              child: Text(
                                "Sign up",
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
                      SizedBox(
                        height: totalHeight * 0.04,
                      ),
                      // bottom section
                      Row(
                        children: [
                          SizedBox(
                            width: totalWidth * 0.2,
                          ),
                          Text(
                            "Already have an account ?  ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: totalWidth * 0.04,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(auth: null),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: totalWidth * 0.04,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
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
