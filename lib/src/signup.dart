import 'package:educa/model/storage.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/gestures.dart';
import 'package:educa/model/authentication.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'colors.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: kEducaBlack,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              'Create account',
              style: textTheme.headline2.copyWith(color: kEducaBlue),
            ),
            Container(
              decoration: BoxDecoration(boxShadow: [
                new BoxShadow(
                  color: kEducaBlue.withOpacity(.2),
                ),
              ], borderRadius: BorderRadius.all(Radius.circular(50))),
              height: 114,
              width: 114,
              child: Image.asset('assets/smile.png'),
            ),
            SizedBox(height: 5),
            SignupForm(),
          ],
        ),
      ),
    ));
  }
}

class SignupForm extends StatefulWidget {
  SignupForm({Key key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _auth = AuthenticationProvider();

  String email, password, name;
  bool agree = false;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  final underlineStyle =
      TextStyle(decoration: TextDecoration.underline, color: kEducaBlue);

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onSaved: (val) => email = val,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter email';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Email',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
            ),
          ),
          SizedBox(height: 10),
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
              hintText: 'password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            onSaved: (val) => name = val,
            validator: (val) {
              if (val.isEmpty) {
                return 'Please enter name';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(5),
              )),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: getImage,
                child: Text(' select image'),
              ),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(
                        _image,
                        height: 100,
                        width: 100,
                      ),
              ),
            ],
          ),

          _buildAcceptTerms(context),

          SizedBox(height: 40),
          // submit buttons
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                onPressed: () {
                  if (_image == null) return;
                  if (_formkey.currentState.validate()) {
                    _formkey.currentState.save();
                    _auth
                        .signUp(email: email, password: password)
                        .then((result) async {
                      if (result == null) {
                        await StorageProvider()
                            .uploadImage(image: _image, username: name);

                        print('uploaded');

                        Navigator.pushReplacementNamed(context, '/created');
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

  Padding _buildAcceptTerms(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Checkbox(
            onChanged: (_) {
              setState(() {
                agree = !agree;
              });
            },
            value: agree,
          ),
          Flexible(
            child: RichText(
              text: TextSpan(
                text: 'By creating account, I agree to ',
                style: TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Terms & Conditions ',
                      style: underlineStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/terms');
                        }),
                  TextSpan(text: ' and  '),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: underlineStyle,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/terms');
                        }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
