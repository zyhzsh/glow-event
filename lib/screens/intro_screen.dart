import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';

import 'guide_screen.dart';

class IntroPage extends StatefulWidget {
  IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage('images/intro.jpg'))),
          ),
          Positioned(
              top: HYSizeFit.setHeight(2.09),
              left: HYSizeFit.setRpx(50),
              child: Text(
                'Welcome to,',
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(60),
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400),
              )),
          Positioned(
              top: HYSizeFit.setHeight(1.85),
              left: HYSizeFit.setRpx(50),
              child: Text(
                'The \nDutch \nFootprint',
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(80),
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                    wordSpacing: 1.5,
                    letterSpacing: 2),
              )),
          Positioned(
            bottom: HYSizeFit.setHeight(10),
            left: HYSizeFit.setRpx(50),
            child: TextButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23.26)),
                padding: EdgeInsets.only(
                    left: HYSizeFit.setRpx(60),
                    right: HYSizeFit.setRpx(60),
                    top: HYSizeFit.setRpx(20),
                    bottom: HYSizeFit.setRpx(20)),
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
                        fontSize: HYSizeFit.setRpx(50),
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
