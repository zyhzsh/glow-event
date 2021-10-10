import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              title: const Text(
                'Info Screen Green',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Information about the green Dutch footprint',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Close'),
                  child: const Text('Close'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (GreenZoneScreen.showOnce == false) {
      Future.delayed(Duration.zero, () => showAlert(context));
      GreenZoneScreen.showOnce = true;
    }
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.transparent,
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.transparent,
              title: const Text(
                'Info Screen Green',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Information about the green Dutch footprint',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Close'),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),

          // showModalBottomSheet(
          //     backgroundColor: Colors.transparent,
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) => FractionallySizedBox(
          //           heightFactor: 1,
          //           child: Info(),
          //         ));

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
                    child: Flower(
                      path: 'images/flower-1.png',
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    width: 200,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-2.png',
                    ),
                    //
                  ),
                  Positioned(
                    top: 500,
                    left: 0,
                    width: 200,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-3.png',
                      beginSize: 10.0,
                      endSize: 200.0,
                      duration: 7,
                    ),
                  ),
                  Positioned(
                    top: 500,
                    left: 300,
                    width: 200,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-4.png',
                    ),
                  ),
                  Positioned(
                    top: 210,
                    left: 20,
                    width: 100,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-5.png',
                      beginSize: 5.0,
                      endSize: 100.0,
                    ),
                  ),
                  Positioned(
                    top: 310,
                    left: 100,
                    width: 100,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-6.png',
                      beginSize: 5.0,
                      endSize: 100.0,
                      duration: 3,
                    ),
                  ),
                  Positioned(
                    top: 400,
                    left: 200,
                    width: 100,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-7.png',
                      beginSize: 5.0,
                      endSize: 100.0,
                      duration: 3,
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 200,
                    width: 100,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-8.png',
                      beginSize: 5.0,
                      endSize: 100.0,
                      duration: 3,
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 10,
                    width: 120,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-9.png',
                      beginSize: 5.0,
                      endSize: 100.0,
                      duration: 3,
                    ),
                  ),
                  Positioned(
                    top: 150,
                    left: 40,
                    width: 120,
                    height: 200,
                    child: Flower(
                      path: 'images/flower-10.png',
                      beginSize: 5.0,
                      endSize: 100.0,
                      duration: 3,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5)),
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
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}

class Flower extends StatefulWidget {
  String path;
  int duration;
  double beginSize;
  double endSize;
  Flower(
      {Key? key,
      this.path = 'images/flower-1.png',
      this.duration = 5,
      this.beginSize = 100.0,
      this.endSize = 200.0})
      : super(key: key);

  @override
  FlowerState createState() => FlowerState();
}

class FlowerState extends State<Flower> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(seconds: widget.duration), vsync: this //
        );
    animation = new Tween(begin: widget.beginSize, end: widget.endSize)
        .animate(controller);
    controller.repeat(reverse: true);
//    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext ctx, Widget? child) {
          return Center(
            child: Container(
              alignment: Alignment.center,
              width: animation.value,
              height: animation.value,
              child: Container(
                decoration: BoxDecoration(
                  image:
                      new DecorationImage(image: AssetImage('${widget.path}')),
                ),
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
