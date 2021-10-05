import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';

class BlackZoneScreen extends StatefulWidget {
  double current_Lat;
  double current_Lnt;
  num distance_to_center;
  BlackZoneScreen(
      {Key? key,
      this.current_Lat = 0.0,
      this.current_Lnt = 0.0,
      this.distance_to_center = 0})
      : super(key: key);
  @override
  _BlackZoneScreenState createState() => _BlackZoneScreenState();
}

class _BlackZoneScreenState extends State<BlackZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Tracker(
            color: Colors.white,
            frequency: 8000,
            current_Lat: widget.current_Lat,
            current_Lng: widget.current_Lnt,
          ),
          Text(
            ' Distance: ${widget.distance_to_center.toInt()} meter' +
                '\n\nYou are currently out of the zones of Glow 2021',
            style: new TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 0.8,
                wordSpacing: 1,
                fontFamily: 'Times new Roman'),
          ),
        ]),
      ),
    );
  }
}
