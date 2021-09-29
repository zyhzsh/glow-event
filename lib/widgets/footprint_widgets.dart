import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/infomation_widgets.dart';
import 'package:vector_math/vector_math.dart' as cal;
import 'package:flutter_compass/flutter_compass.dart';

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
    return Stack(alignment: Alignment.center, children: [
      Container(
          height: 400,
          width: 400,
          child: WaterRipple(
            count: 1,
            color: widget.color,
            frequency: widget.frequency,
          )),
      FloatingActionButton(
        backgroundColor: Color(0x7F7F7F),
        onPressed: () => {
          showCupertinoModalPopup(
              context: context, builder: (context) => Info())
        },
        child: Container(
          child: Compass(
            current_lat: widget.current_Lat,
            current_lng: widget.current_Lng,
          ),
        ),
      ),
    ]);
  }
}

// Pulse Animation
class WaterRipple extends StatefulWidget {
  final int count;
  final Color color;
  final int frequency;
  const WaterRipple({
    Key? key,
    this.count = 1,
    this.color = Colors.white,
    this.frequency = 5000,
  }) : super(key: key);

  @override
  _WaterRippleState createState() => _WaterRippleState();
}

class _WaterRippleState extends State<WaterRipple>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.frequency))
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WaterRipplePainter(_controller.value,
              count: widget.count, color: widget.color),
        );
      },
    );
  }
}

class WaterRipplePainter extends CustomPainter {
  final double progress;
  final int count;
  final Color color;

  Paint _paint = Paint()..style = PaintingStyle.fill;
  WaterRipplePainter(this.progress,
      {this.count = 3, this.color = const Color(0xFF0080ff)});
  @override
  void paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2, size.height / 2);
    for (int i = count; i >= 0; i--) {
      final double opacity = (1.0 - ((i + progress) / (count + 1)));
      final Color _color = color.withOpacity(opacity);
      _paint..color = _color;

      double _radius = radius * ((i + progress) / (count + 1));

      canvas.drawCircle(
          Offset(size.width / 2, size.height / 2), _radius, _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// Compass Direction
class Compass extends StatefulWidget {
  double current_lat;
  double current_lng;
  final double center_Lat;
  final double center_Lng;
  // Green Zone Center : 51.447717, 5.456978
  // Fontys Building Test Center : 51.450744, 5.454335
  // Testing Location : 51.560136, 5.056212
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
    print('Bearing: --------------------------------:${offset}');
    var offsetAngle = -2 * pi * (x - offset) / 360;
    print('Orginal: ----------------------------------- :${x}');

    print('Result:-------------------------------:${offsetAngle}');
    if (mounted) {
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
        child: Image.asset('images/footprint-fixed.png'),
      ),
    ));
  }
}
