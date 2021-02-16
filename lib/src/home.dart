import 'package:educa/src/booktab.dart';
import 'package:educa/src/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BookTab(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: kEducaBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Icon(Icons.video_call_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (val) => setState(() => _currentIndex = val),
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: '.',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.messenger_outline),
            label: '.',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(right: 40.0),
              child: Icon(Icons.person_outline),
            ),
            label: '.',
          )
        ],
      ),
    );
  }
}
