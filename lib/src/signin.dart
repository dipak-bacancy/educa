import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';

class Signin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 110),
            Center(
              child: Text('Sign In',
                  style: textTheme.headline1.copyWith(color: kEducaBlue)),
            ),
            // SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(48.0),
              child: SigninForm(),
            ),
          ],
        ),
      ),
    );
  }
}

class SigninForm extends StatefulWidget {
  SigninForm({Key key}) : super(key: key);

  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Email Address',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              suffix: Text('Forgot?'),
              hintText: 'Password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  // Respond to button press
                },
                child: Text(
                  'Continue',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: kEducaWhite),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
