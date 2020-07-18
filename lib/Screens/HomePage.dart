import 'package:auto_size_text/auto_size_text.dart';
import 'package:blood_donation/Screens/Loading.dart';
import 'package:blood_donation/Services/Auth.dart';
import 'package:blood_donation/Widgets/CustomDrawer.dart';
import 'package:blood_donation/Widgets/UserCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final AuthBase auth;
  HomePage({@required this.auth});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // mian method to fetch data
  Future<QuerySnapshot> getUsers() {
    return Firestore.instance.collection("Donors").getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    // total height and width constrains
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[50],
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
          title: Center(
            child: Text(
              "Home",
              style: GoogleFonts.meriendaOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        endDrawer: CustomDrawer(auth: widget.auth),
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getUsers(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: <Widget>[
                    Container(
                      color: Colors.pink[50],
                      height: totalHeight * 1,
                      width: totalWidth * 1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(
                            totalWidth: totalWidth,
                            totalHeight: totalHeight,
                            ppUrl: snapshot
                                .data.documents[index].data["profilePic"],
                            name: snapshot.data.documents[index].data["name"],
                            bloodGroup: snapshot
                                .data.documents[index].data["bloodGroup"],
                            lastDonation: snapshot
                                .data.documents[index].data["lastDonation"],
                            totalDonation:
                                "${snapshot.data.documents[index].data["totalDonations"]}",
                            location:
                                snapshot.data.documents[index].data["location"],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return Container(
                child: Center(
                  child: Loading(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
