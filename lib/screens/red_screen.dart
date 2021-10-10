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
        //Back-Up options
        // onPressed: () {
        //   showModalBottomSheet(
        //       backgroundColor: Colors.transparent,
        //       isScrollControlled: true,
        //       context: context,
        //       builder: (context) => FractionallySizedBox(
        //             heightFactor: 1,
        //             child: Info(),
        //           ));
        // },
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Info Screen Red',
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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/smog.png"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                  begin: Alignment(1.0, -5),
                  end: Alignment(-1.0, 3),
                  colors: [Color(0xFFACACAC), Color(0xFFEC101A)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  'You are currently in \n Red zone (4.9 hectares) ',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      letterSpacing: 0.8,
                      wordSpacing: 1,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                height: 200,
                width: 200,
                // child: PulseEffect_A(
                //   count: 1,
                //   color: Colors.white,
                //   frequency: 2000,
                // )
                child: PulseEffect_B(
                  glowColor: Colors.red.shade50,
                  backcolor: Color(0xFFEC101A),
                  frequency: 800,
                ),
              ),
              Text(
                'Distance to glow zone :\n ${widget.distance_to_center.toInt()} meters',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 0.8,
                    wordSpacing: 1,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 10.0, height: 10.0),
              Tracker(
                color: Colors.white,
                frequency: 1000,
                current_Lat: widget.current_Lat,
                current_Lng: widget.current_Lnt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
