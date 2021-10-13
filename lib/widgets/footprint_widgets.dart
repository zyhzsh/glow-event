import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:vector_math/vector_math.dart' as cal;

class Tracker extends StatefulWidget {
  final Color color;
  final int frequency;
  final double current_Lat;
  final double current_Lng;
  Tracker(
      {Key? key,
      this.color = Colors.red,
      this.frequency = 2000,
      this.current_Lat = 0,
      this.current_Lng = 0})
      : super(key: key);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  @override
  Widget build(BuildContext context) {
    return Compass(
      current_lat: widget.current_Lat,
      current_lng: widget.current_Lng,
    );
  }
}

// Compass Direction
class Compass extends StatefulWidget {
  double current_lat;
  double current_lng;
  final double center_Lat;
  final double center_Lng;
  // Green Zone Center : 51.447717, 5.456978
  Compass(
      {Key? key,
      this.current_lat = 0,
      this.current_lng = 0,
      //Green Center Location
      this.center_Lat = 51.447717,
      this.center_Lng = 5.456978})
      : super(key: key);
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _heading = 0;

  double getOffsetFromNorth(double currentLatitude, double currentLongitude,
      double targetLatitude, double targetLongitude) {
    var la_rad = cal.radians(currentLatitude);
    var lo_rad = cal.radians(currentLongitude);

    var de_la = cal.radians(targetLatitude);
    var de_lo = cal.radians(targetLongitude);

    var toDegrees = cal.degrees(atan(sin(de_lo - lo_rad) /
        ((cos(la_rad) * tan(de_la)) - (sin(la_rad) * cos(de_lo - lo_rad)))));
    if (la_rad > de_la) {
      if ((lo_rad > de_lo || lo_rad < cal.radians(-180.0) + de_lo) &&
          toDegrees > 0.0 &&
          toDegrees <= 90.0) {
        toDegrees += 180.0;
      } else if (lo_rad <= de_lo &&
          lo_rad >= cal.radians(-180.0) + de_lo &&
          toDegrees > -90.0 &&
          toDegrees < 0.0) {
        toDegrees += 180.0;
      }
    }
    if (la_rad < de_la) {
      if ((lo_rad > de_lo || lo_rad < cal.radians(-180.0) + de_lo) &&
          toDegrees > 0.0 &&
          toDegrees < 90.0) {
        toDegrees += 180.0;
      }
      if (lo_rad <= de_lo &&
          lo_rad >= cal.radians(-180.0) + de_lo &&
          toDegrees > -90.0 &&
          toDegrees <= 0.0) {
        toDegrees += 180.0;
      }
    }
    return toDegrees;
  }

  @override
  void initState() {
    super.initState();
    FlutterCompass.events.listen(_onData);
  }

  void _onData(double x) {
    var offset = getOffsetFromNorth(widget.current_lat, widget.current_lng,
        widget.center_Lat, widget.center_Lng);
    var offsetAngle = -2 * pi * (x - offset) / 360;
    if (this.mounted) {
      setState(() {
        _heading = offsetAngle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        child: Transform.rotate(
      angle: _heading,
      child: Center(
          child: Container(
        height: 120,
        child: Image.asset('images/footprint-fixed.png'),
      )),
    ));
  }
}
