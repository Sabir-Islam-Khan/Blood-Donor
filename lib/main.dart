import 'package:blood_donation/Animations/RegistrationAnimation.dart';
import 'package:blood_donation/Screens/Register.dart';
import 'package:blood_donation/Services/Auth.dart';
import 'package:blood_donation/Services/LandingPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BloodDonation());
}

class BloodDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: LandingPage(
        auth: Auth(),
      )),
    );
  }
}
