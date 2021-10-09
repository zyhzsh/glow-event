import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  bool openGuideScreen = false;
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: TextButton(
          onPressed: () {
            setState(() {
              widget.openGuideScreen = true;
            });
          },
          child: Container(
              padding: EdgeInsets.only(top: 8), child: Text('Start'))),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/intro.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}

//
//
// class IntroPage extends StatelessWidget {
//
//   const IntroPage({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
