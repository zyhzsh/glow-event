import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';
import 'package:glow2021v1/widgets/infomation_widgets.dart';

class GreenZoneScreen extends StatefulWidget {
  double current_Lat;
  double current_Lnt;
  num distance_to_center;
  static bool showOnce = false;
  GreenZoneScreen({
    Key? key,
    this.current_Lat = 0.0,
    this.current_Lnt = 0.0,
    this.distance_to_center = 0,
  }) : super(key: key);
  @override
  _GreenZoneScreenState createState() => _GreenZoneScreenState();
}

class _GreenZoneScreenState extends State<GreenZoneScreen> {
  Widget GetMessageForUser() {
    if (widget.distance_to_center.toInt() <= 20) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Text(
            'You\'re standing in the center.\n Yeah ~! raise your hand, let\'s celebrate.',
            textAlign: TextAlign.center,
            style: new TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 0.8,
                wordSpacing: 1,
                fontFamily: 'Montserrat'),
          ));
    } else {
      return Text(
        'Great ~ !\n You are getting closer \n ${widget.distance_to_center.toInt()} meters',
        textAlign: TextAlign.center,
        style: new TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            letterSpacing: 0.8,
            wordSpacing: 1,
            fontFamily: 'Montserrat'),
      );
    }
    return Text('');
  }

  Widget Getfootprint() {
    if (widget.distance_to_center.toInt() > 20) {
      return Tracker(
        color: Colors.white,
        frequency: 700,
        current_Lat: widget.current_Lat,
        current_Lng: widget.current_Lnt,
      );
    } else {
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                context: context,
                builder: (context) => FractionallySizedBox(
                      heightFactor: 1,
                      child: Info(),
                    ));
          },
          child: Container(
              padding: EdgeInsets.only(top: 8),
              child: new Image.asset(
                'images/arrow-up.gif',
                gaplessPlayback: false,
              )),
        ),
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment(1.0, -5),
                      end: Alignment(-1.0, 3),
                      colors: [Color(0xffACACAC), Color(0xff7CD034)])),
              child: Stack(
                children: [
                  Positioned(
                    top: 170,
                    left: 180,
                    width: 200,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('images/flower-1.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    width: 200,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('images/flower-2.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 500,
                    left: 0,
                    width: 200,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('images/flower-3.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 500,
                    left: 300,
                    width: 200,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('images/flower-4.png')),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 210,
                    left: 20,
                    width: 100,
                    height: 200,
                    child: Container(
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('images/flower-5.png')),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Getfootprint(),
                      GetMessageForUser(),
                    ],
                  ),
                ],
              )),
        ));
  }
}

//

//
// class flower extends StatefulWidget {
//   const flower({Key? key}) : super(key: key);
//
//   @override
//   _flowerState createState() => _flowerState();
// }
//
// class _flowerState extends State<flower> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<int> _animation;
//   @override
//   void initState() {
//     _controller = new AnimationController(
//         vsync: this, duration: const Duration(seconds: 5))
//       ..repeat();
//     _animation = new IntTween(begin: 0, end: 80).animate(_controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: new AnimatedBuilder(
//         animation: _animation,
//         builder: (BuildContext context, Widget? child) {
//           return new Image.asset(
//             'images/flower.gif',
//             gaplessPlayback: true,
//           );
//         },
//       ),
//     );
//   }
// }
