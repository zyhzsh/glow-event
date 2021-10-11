import 'dart:math';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Pulse Effect A
//Water ripple
class PulseEffect_A extends StatefulWidget {
  final int count;
  final Color color;
  final int frequency;
  const PulseEffect_A({
    Key? key,
    this.count = 1,
    this.color = Colors.white,
    this.frequency = 5000,
  }) : super(key: key);

  @override
  _PulseEffect_AState createState() => _PulseEffect_AState();
}

class _PulseEffect_AState extends State<PulseEffect_A>
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

//Pulse Effect B
//AvatarGlow
class PulseEffect_B extends StatefulWidget {
  final Color glowColor;
  final Color backcolor;
  final int frequency;

  PulseEffect_B({
    Key? key,
    this.glowColor = Colors.green,
    this.backcolor = Colors.white,
    this.frequency = 2000,
  }) : super(key: key);

  @override
  _PulseEffect_BState createState() => _PulseEffect_BState();
}

class _PulseEffect_BState extends State<PulseEffect_B> {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
        glowColor: widget.glowColor,
        endRadius: 150.0,
        duration: Duration(milliseconds: widget.frequency),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: Duration(milliseconds: 100),
        child: Material(
            elevation: 0.0,
            shape: CircleBorder(),
            child: CircleAvatar(
              backgroundColor: widget.backcolor,
              radius: 0.0,
            )));
  }
}
