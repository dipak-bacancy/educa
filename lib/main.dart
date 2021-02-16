import 'package:educa/src/colors.dart';
import 'package:educa/src/home.dart';
import 'package:educa/src/signin.dart';
import 'package:educa/src/splash.dart';
import 'package:educa/src/video.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildKeducaTheme(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        '/signin': (context) => Signin(),
        '/home': (context) => Home(),
        '/video': (context) => Video(),
      },
    );
  }

  ThemeData _buildKeducaTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: _buildEducaTexttheme(),

      iconTheme: IconThemeData(color: kEducaWhite),

//
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 3,
        selectedItemColor: kEducaBlue,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(color: kEducaBlue, size: 24),
        type: BottomNavigationBarType.fixed,
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: kEducaBlue,
        ),
      ),
    );
  }

  TextTheme _buildEducaTexttheme() {
    return TextTheme(
      button: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),

      /// body
      bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),

      bodyText2: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),

      ///  Headlines
      headline1: TextStyle(
          fontSize: 30, fontWeight: FontWeight.w900, color: kEducaBlack),

      headline2: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),

      headline3: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),

      headline5: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),

      headline6: TextStyle(fontSize: 9, fontWeight: FontWeight.w200),

      /// Subtitles
      subtitle2: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
    );
  }
}
