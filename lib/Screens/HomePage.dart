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
  Widget buildItem(
    DocumentSnapshot doc,
    BuildContext ctx,
    double totalHeight,
    double totalWidth,
  ) {
    return UserCard(
      auth: widget.auth,
      totalWidth: totalWidth,
      totalHeight: totalHeight,
      ppUrl: doc.data["profilePic"],
      name: doc.data["name"],
      bloodGroup: doc.data["bloodGroup"],
      lastDonation: doc.data["lastDonation"],
      totalDonation: "${doc.data["totalDonations"]}",
      location: doc.data["location"],
      pageName: "HomePage",
    );
  }

  // mian method to fetch data
  Future<QuerySnapshot> getUsers() {
    return Firestore.instance.collection("Donors").getDocuments();
  }

  String searchText;
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
          child: SafeArea(
            // column for the whole body
            child: Column(
              children: [
                // padding for title
                // search box
                SizedBox(
                  height: totalHeight * 0.02,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(244, 245, 249, 1),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  height: totalHeight * 0.05,
                  width: totalWidth * 0.94,
                  child: TextField(
                    onChanged: (text) {
                      text = text.toUpperCase();

                      setState(() {
                        searchText = text;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search Keywords",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                searchText == null
                    ? SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection('Donors')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: snapshot.data.documents
                                    .map((doc) => buildItem(
                                          doc,
                                          context,
                                          totalHeight,
                                          totalWidth,
                                        ))
                                    .toList(),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream:
                            Firestore.instance.collection('Donors').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final results = snapshot.data.documents.where(
                              (DocumentSnapshot a) =>
                                  a.data['location']
                                      .toString()
                                      .toUpperCase()
                                      .contains(
                                        searchText.toUpperCase(),
                                      ) ||
                                  a.data['bloodGroup']
                                      .toString()
                                      .toUpperCase()
                                      .contains(
                                        searchText.toUpperCase(),
                                      ) ||
                                  a.data['name']
                                      .toString()
                                      .toUpperCase()
                                      .contains(
                                        searchText.toUpperCase(),
                                      ),
                            );
                            return Column(
                              children: results
                                  .map((doc) => buildItem(
                                        doc,
                                        context,
                                        totalHeight,
                                        totalWidth,
                                      ))
                                  .toList(),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                SizedBox(
                  height: totalHeight * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
