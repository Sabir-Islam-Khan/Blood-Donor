import 'package:blood_donation/Services/Auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AuthBase auth;
  HomePage({@required this.auth});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: totalHeight * 1,
          width: totalWidth * 1,
          color: Colors.amberAccent,
          child: Center(
            child: Text(
              "USER SIDE APP",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
