import 'package:educa/model/authentication.dart';
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
  final _auth = AuthenticationProvider();

  String email, password;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          // Email field
          TextFormField(
            onSaved: (val) => email = val,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Email Address',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
            ),
          ),
          // passwod feild
          TextFormField(
            obscureText: true,
            onSaved: (val) => password = val,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
            decoration: InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/forgot'),
                  child: Text(
                    'Forgot?',
                    style: textTheme.headline3.copyWith(color: kEducaBlue),
                  ),
                ),
              ),
              hintText: 'Password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
            ),
          ),
          SizedBox(height: 20),

          // submit buttons
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    _auth
                        .signIn(email: email, password: password)
                        .then((result) {
                      if (result == null) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(result)));
                      }
                    });
                  }
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
