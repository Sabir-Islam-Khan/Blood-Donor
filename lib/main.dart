import 'package:blood_donation/Services/Auth.dart';
import 'package:blood_donation/Services/LandingPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BloodDonation());
}

class BloodDonation extends StatefulWidget {
  @override
  _BloodDonationState createState() => _BloodDonationState();
}

class _BloodDonationState extends State<BloodDonation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LandingPage(
          auth: Auth(),
        ),
      ),
    );
  }
}
