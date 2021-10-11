import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';
import 'package:glow2021v1/widgets/information_widgets.dart';
import 'package:glow2021v1/widgets/pluse_widgets.dart';

class RedZoneScreen extends StatefulWidget {
  double current_Lat;
  double current_Lnt;
  num distance_to_center;
  RedZoneScreen(
      {Key? key,
      this.current_Lat = 0.0,
      this.current_Lnt = 0.0,
      this.distance_to_center = 0})
      : super(key: key);
  @override
  _RedZoneScreenState createState() => _RedZoneScreenState();
}

class _RedZoneScreenState extends State<RedZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Info Screen Red',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Information about the red Dutch footprint',
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
        child: Container(
            padding: EdgeInsets.only(top: 8),
            child: new Image.asset(
              'images/arrow-up.gif',
              gaplessPlayback: false,
            )),
      ),
      body: Scaffold(
          backgroundColor: Color(0xFFEC101A),
          body: Stack(
            children: [
              Positioned(
                top: 370,
                left: 80,
                width: 250,
                height: 250,
                child: Row(
                  children: [
                    Expanded(
                        child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        child: Tracker(
                          color: Colors.white,
                          frequency: 1000,
                          current_Lat: widget.current_Lat,
                          current_Lng: widget.current_Lnt,
                        ),
                        height: 120.0,
                      ),
                    ))
                  ],
                ),
              ),
              Positioned(
                top: 150,
                left: 80,
                width: 250,
                height: 250,
                child: Center(
                  child: PulseEffect_B(
                    glowColor: Colors.red.shade50,
                    backcolor: Color(0xFFEC101A),
                    frequency: 2000,
                  ),
                ),
              ),
              Positioned(
                  top: 420,
                  left: 80,
                  width: 270,
                  height: 250,
                  child: Text(
                    "Distance to centre of the green zone: ${widget.distance_to_center.toInt()} metres",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, height: 1.5, fontSize: 18),
                  )),
            ],
          )),
    );
  }
}
