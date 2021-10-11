import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';
import 'package:glow2021v1/widgets/pluse_widgets.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Info Screen Black',
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
        child: Container(
            padding: EdgeInsets.only(top: 8),
            child: new Image.asset(
              'images/arrow-up.gif',
              gaplessPlayback: false,
            )),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'You are currently out of the zones of Glow 2021',
          style: new TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              letterSpacing: 0.8,
              wordSpacing: 1,
              fontFamily: 'Times new Roman'),
        ),
      ),
    );
  }
}
