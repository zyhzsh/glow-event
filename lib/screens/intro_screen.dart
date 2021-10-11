import 'package:flutter/material.dart';

import 'guide_screen.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/intro.jpg'))),
          ),
          Positioned(
              top: 390.0,
              left: 20.0,
              child: Text(
                'Welcome to,',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400),
              )),
          Positioned(
              top: 430.0,
              left: 20.0,
              child: Text(
                'The \nDutch \nFootprint',
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1.5,
                    letterSpacing: 2),
              )),
          Positioned(
            bottom: 50.0,
            left: 20.0,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.26)),
                padding:
                    EdgeInsets.only(left: 32, right: 32, top: 18, bottom: 18),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GuidePage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    'Start ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  )),
                  Icon(
                    Icons.arrow_forward_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
