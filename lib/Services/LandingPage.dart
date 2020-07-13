import 'package:flutter/material.dart';
import '../Screens/HomePage.dart';
import '../Screens/Signin.dart';
import '../Services/Auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LandingPage extends StatelessWidget {
  // authbase instance

  final AuthBase auth;
  final String email;
  LandingPage({@required this.auth, @optionalTypeArgs this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;

          if (user == null) {
            return SignIn(
              auth: auth,
            );
          }
          return HomePage(
            auth: auth,
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
