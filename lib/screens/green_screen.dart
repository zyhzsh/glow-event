import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class GreenZoneScreen extends StatefulWidget {
  double current_Lat;
  double current_Lnt;
  num distance_to_center;
  GreenZoneScreen(
      {Key? key,
      this.current_Lat = 0.0,
      this.current_Lnt = 0.0,
      this.distance_to_center = 0})
      : super(key: key);

  @override
  _GreenZoneScreenState createState() => _GreenZoneScreenState();
}

class _GreenZoneScreenState extends State<GreenZoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
