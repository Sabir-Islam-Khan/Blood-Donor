import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:supercharged/supercharged.dart';

class RegisterAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child: AnimatedBackground()),
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Positioned.fill(child: CenteredText()),
      ],
    );
  }

  Widget onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: LoopAnimation<double>(
            duration: (5000 / speed).round().milliseconds,
            tween: 0.0.tweenTo(2 * pi),
            builder: (context, child, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum _BgProps { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_BgProps>()
      ..add(
          _BgProps.color1,
          Color.fromRGBO(237, 66, 101, 1).tweenTo(
            Color.fromRGBO(239, 44, 120, 1),
          ))
      ..add(
          _BgProps.color2,
          Color(0xffA83279).tweenTo(
            Color.fromRGBO(237, 66, 101, 1),
          ))
      ..add(
          _BgProps.color2,
          Color(0xffA83279).tweenTo(
            Color.fromRGBO(239, 79, 79, 1),
          ));

    return MirrorAnimation<MultiTweenValues<_BgProps>>(
      tween: tween,
      duration: 3.seconds,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                value.get(_BgProps.color1),
                value.get(_BgProps.color2)
              ])),
        );
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  const CenteredText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        SizedBox(
          height: totalHeight * 0.4,
        ),
        Center(
          child: Text(
            "Congrats!",
            style: GoogleFonts.meriendaOne(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textScaleFactor: 4.2,
          ),
        ),
        SizedBox(
          height: totalHeight * 0.02,
        ),
        Center(
          child: Text(
            "Your registration was successful !",
            style: GoogleFonts.meriendaOne(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            textScaleFactor: 1.3,
          ),
        ),
      ],
    );
  }
}
