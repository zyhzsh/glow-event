import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';
import 'package:glow2021v1/widgets/geofence_widgets.dart';

class GuidePage extends StatelessWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Container(
            height: HYSizeFit.setHeight(2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(22.0),
                    bottomLeft: Radius.circular(22.0)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('images/footprint_background_img.jpg'))),
          ),
          Stack(
            children: [
              Positioned(
                top: HYSizeFit.setHeight(18),
                left: HYSizeFit.setWidth(300),
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
                top: HYSizeFit.setHeight(9),
                left: HYSizeFit.setWidth(50),
                child: Container(
                  child: Text('In order',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HYSizeFit.setRpx(46),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Positioned(
                top: HYSizeFit.setHeight(6),
                left: HYSizeFit.setWidth(50),
                child: Container(
                  child: Text('To \nCreate \nThe \nBest \nExperience',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HYSizeFit.setRpx(68),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                top: HYSizeFit.setHeight(2),
                left: HYSizeFit.setWidth(50),
                child: Container(
                  width: HYSizeFit.setRpx(700),
                  height: HYSizeFit.setRpx(800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: HYSizeFit.setHeight(20),
                      ),
                      Text('User of flashlight',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: HYSizeFit.setRpx(40),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: HYSizeFit.setHeight(100),
                      ),
                      Text(
                          'is simply dummy text of the printing and type \nsetting'
                          'industry is dummy text for the. \nLorem Ipsum has been the industry\'s \nstandard'
                          'dummy text ever since the 1500s.',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: HYSizeFit.setRpx(30),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w300)),
                      SizedBox(
                        height: HYSizeFit.setHeight(50),
                      ),
                      SizedBox(
                        width: HYSizeFit.setRpx(370),
                        child: TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shadowColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23.26)),
                            padding: EdgeInsets.only(
                                left: HYSizeFit.setWidth(50),
                                right: HYSizeFit.setWidth(50),
                                top: HYSizeFit.setHeight(60),
                                bottom: HYSizeFit.setHeight(60)),
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
                                    fontSize: HYSizeFit.setRpx(40),
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
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// onPressed: () {
// Navigator.pop(context);
// },
