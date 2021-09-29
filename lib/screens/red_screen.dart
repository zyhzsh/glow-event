import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return Container();
  }
}
