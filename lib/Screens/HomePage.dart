import 'package:blood_donation/Services/Auth.dart';
import 'package:flutter/material.dart';

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
        body: Container(
          height: totalHeight * 1,
          width: totalWidth * 1,
          color: Colors.amberAccent,
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
    );
  }
}
