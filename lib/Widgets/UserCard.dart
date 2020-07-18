import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserCard extends StatelessWidget {
  final double totalWidth;
  final double totalHeight;
  final String ppUrl;
  final String name;
  final String bloodGroup;
  final String lastDonation;
  final String totalDonation;
  final String location;

  UserCard(
      {@required this.totalWidth,
      @required this.totalHeight,
      @required this.ppUrl,
      @required this.name,
      @required this.bloodGroup,
      @required this.lastDonation,
      @required this.totalDonation,
      @required this.location});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: totalHeight * 0.01,
        ),
        Center(
          child: Container(
            height: totalHeight * 0.275,
            width: totalWidth * 0.98,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(239, 44, 120, 1),
                  Color.fromRGBO(237, 66, 101, 1),
                  Color.fromRGBO(239, 79, 79, 1),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink[200],
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(5, 5), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: totalHeight * 0.02,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: totalWidth * 0.04,
                    ),
                    Container(
                      width: totalWidth * 0.3,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: ClipOval(
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(
                                this.ppUrl,
                                loadingBuilder: (context, child, progress) {
                                  return progress == null
                                      ? child
                                      : Image(
                                          image: AssetImage(
                                              'assets/images/avatar.png'),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: totalWidth * 0.04,
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: totalWidth * 0.6,
                          // resizable text for name
                          child: AutoSizeText(
                            this.name,
                            style: GoogleFonts.meriendaOne(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: totalWidth * 0.6,
                          // resizable text for blood group
                          child: AutoSizeText(
                            'Blood Group : ${this.bloodGroup}',
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: totalWidth * 0.6,
                          // resizable text for blood group
                          child: AutoSizeText(
                            'Last Donation : ${this.lastDonation}',
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: totalWidth * 0.6,
                          // resizable text for blood group
                          child: AutoSizeText(
                            'Total Donation : ${this.totalDonation}',
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: totalWidth * 0.6,
                          // resizable text for name
                          child: AutoSizeText(
                            '${this.location}, Lalmonirhat',
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: totalHeight * 0.02,
                ),
                Container(
                  height: totalHeight * 0.05,
                  width: totalWidth * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink[600],
                        Colors.pink[700],
                        Colors.pink[800],
                      ],
                    ),
                  ),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: totalWidth * 0.06,
                        ),
                        Container(
                          width: totalWidth * 0.6,
                          child: AutoSizeText(
                            "Call a Moderator to request",
                            style: GoogleFonts.meriendaOne(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Image(
                          height: 25.0,
                          width: 25.0,
                          image: AssetImage('assets/images/phone.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}