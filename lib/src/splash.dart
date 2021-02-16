import 'dart:async';

import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(
        _duration, () => Navigator.pushReplacementNamed(context, '/signin'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: kEducaBlue),
      child: Center(
          child: Text('educa',
              style: TextStyle(
                fontSize: 72,
                color: Colors.white,
                fontFamily: GoogleFonts.neuton().fontFamily,
              ))),
    ));
  }
}
