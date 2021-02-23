import 'dart:async';

import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';

class Created extends StatefulWidget {
  @override
  _CreatedState createState() => _CreatedState();
}

class _CreatedState extends State<Created> {
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/smile.png',
                color: kEducaBlack,
              ),
              SizedBox(height: 20),
              Text(
                'Your account has been ',
                style: textTheme.headline2.copyWith(color: kEducaBlue),
              ),
              Text(
                ' created successfully.',
                style: textTheme.headline2.copyWith(color: kEducaBlue),
              ),
              SizedBox(height: 20),
              Text(
                'We are setting up your profile. You will be ',
                style: textTheme.bodyText1,
              ),
              Text(
                'redirected in few minutes...',
                style: textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
