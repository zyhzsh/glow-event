import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/infomation_widgets.dart';

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

class Tracker extends StatefulWidget {
  final Color color;
  final int frequency;

  const Tracker({Key? key, this.color = Colors.red, this.frequency = 2000})
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
        child: Image.asset('images/arrow.png'),
      ),
    ]);
  }
}
