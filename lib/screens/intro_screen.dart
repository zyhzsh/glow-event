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
                    fit: BoxFit.fill,
                    image: AssetImage('images/intro_page_v1.png'))),
          ),
          Positioned(
            bottom: HYSizeFit.setHeight(10),
            right: HYSizeFit.setRpx(50),
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
                    'Verder ',
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
