import 'package:blood_donation/Services/Auth.dart';

import 'package:blood_donation/Widgets/UserCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'HomePage.dart';

class TopDonors extends StatefulWidget {
  final Auth auth;

  TopDonors({@required this.auth});
  @override
  _TopDonorsState createState() => _TopDonorsState();
}

class _TopDonorsState extends State<TopDonors> {
  // search text

  String searchText;

  // main card

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
      pageName: "TopDonors",
    );
  }

  @override
  Widget build(BuildContext context) {
    // toal height and width constrains

    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: HomePage(auth: widget.auth),
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
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
              "Top Donors",
              style: GoogleFonts.meriendaOne(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            // column for the whole body
            child: Column(
              children: [
                // padding for title
                // search box
                SizedBox(
                  height: totalHeight * 0.01,
                ),
                SingleChildScrollView(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('Donors')
                        .orderBy("totalDonations", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: totalWidth * 1,
                          height: totalHeight * 0.9,
                          child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return UserCard(
                                auth: widget.auth,
                                totalWidth: totalWidth,
                                totalHeight: totalHeight,
                                ppUrl: snapshot
                                    .data.documents[index].data["profilePic"],
                                name:
                                    snapshot.data.documents[index].data["name"],
                                bloodGroup:
                                    snapshot.data.documents[index].data["name"],
                                lastDonation: snapshot
                                    .data.documents[index].data["lastDonation"],
                                totalDonation:
                                    "${snapshot.data.documents[index].data["totalDonations"]}",
                                location: snapshot
                                    .data.documents[index].data["location"],
                                pageName: 'TopDonors',
                                index: index,
                              );
                            },
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
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
