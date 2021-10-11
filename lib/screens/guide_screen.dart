import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/geofence_widgets.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Container(
            height: 463.72,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(22.0),
                    bottomLeft: Radius.circular(22.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/footprint_background_img.jpg'))),
          ),
          SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Container(
                      child: Text('In order',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 27.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  Positioned(
                    top: 90,
                    left: 20,
                    child: Container(
                      child: Text('To \nCreate \nThe \nBest \nExperience',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45.55,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Positioned(
                    bottom: 270,
                    left: 20,
                    child: Container(
                      child: Text('User of flashlight',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  Positioned(
                    bottom: 150,
                    left: 20,
                    child: Container(
                      child: Text(
                          'is simply dummy text of the printing and \ntypesetting'
                          'industry. \n\nLorem Ipsum has been the industry\'s \nstandard'
                          'dummy text ever since the 1500s.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300)),
                    ),
                  ),
                  Positioned(
                    bottom: 50.0,
                    left: 20.0,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.26)),
                        padding: EdgeInsets.only(
                            left: 32, right: 32, top: 18, bottom: 18),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => new GlowApp()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            'Let\'s Start! ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),
                          )),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
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

// onPressed: () {
// Navigator.pop(context);
// },
