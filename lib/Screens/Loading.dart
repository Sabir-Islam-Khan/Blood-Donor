import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    return Container(
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
      child: Center(
        child: Container(
          height: 250.00,
          width: 250.00,
          child: LiquidCircularProgressIndicator(
            value: 0.5, // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(
                Colors.pink), // Defaults to the current Theme's accentColor.
            backgroundColor: Colors.lightBlue[
                300], // Defaults to the current Theme's backgroundColor.
            direction: Axis
                .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
            center: Text(
              "Please Wait...",
              style: GoogleFonts.meriendaOne(
                color: Colors.black,
                fontSize: 26.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
