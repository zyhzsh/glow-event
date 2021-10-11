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
      //   floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.transparent,
      //     onPressed: () => showDialog<String>(
      //       context: context,
      //       builder: (BuildContext context) => AlertDialog(
      //         backgroundColor: Colors.transparent,
      //         title: const Text(
      //           'Info Screen Black',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         content: const Text(
      //           'Information about the green Dutch footprint',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         actions: <Widget>[
      //           TextButton(
      //             onPressed: () => Navigator.pop(context, 'Close'),
      //             child: const Text('Close'),
      //           ),
      //         ],
      //       ),
      //     ),
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
        // showModalBottomSheet(
        //     backgroundColor: Colors.transparent,
        //     isScrollControlled: true,
        //     context: context,
        //     builder: (context) => FractionallySizedBox(
        //           heightFactor: 1,
        //           child: Info(),
        //         ));
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
    //Back-up
    // return Scaffold(
    //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.transparent,
    //     onPressed: () => showDialog<String>(
    //       context: context,
    //       builder: (BuildContext context) => AlertDialog(
    //         backgroundColor: Colors.transparent,
    //         title: const Text(
    //           'Info Screen Black',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         content: const Text(
    //           'Information about the green Dutch footprint',
    //           style: TextStyle(color: Colors.white),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () => Navigator.pop(context, 'Close'),
    //             child: const Text('Close'),
    //           ),
    //         ],
    //       ),
    //     ),

    //     // showModalBottomSheet(
    //     //     backgroundColor: Colors.transparent,
    //     //     isScrollControlled: true,
    //     //     context: context,
    //     //     builder: (context) => FractionallySizedBox(
    //     //           heightFactor: 1,
    //     //           child: Info(),
    //     //         ));
    //     child: Container(
    //         padding: EdgeInsets.only(top: 8),
    //         child: new Image.asset(
    //           'images/arrow-up.gif',
    //           gaplessPlayback: false,
    //         )),
    //   ),
    //   body: Center(
    //     child: Container(
    //       decoration: BoxDecoration(
    //           gradient: LinearGradient(
    //               begin: Alignment(1.0, -5),
    //               end: Alignment(-1.0, 3),
    //               colors: [Color(0xff737373), Color(0xff0E181A)])),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             child: Text(
    //               'You are currently in \n no zone',
    //               textAlign: TextAlign.center,
    //               style: new TextStyle(
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 30,
    //                   letterSpacing: 0.8,
    //                   wordSpacing: 1,
    //                   fontFamily: 'Montserrat'),
    //             ),
    //           ),
    //           Container(
    //             height: 200,
    //             width: 200,
    //             // child: PulseEffect_A(
    //             //   count: 1,
    //             //   color: Colors.white,
    //             //   frequency: 2000,
    //             // )
    //             child: PulseEffect_B(
    //               glowColor: Colors.green.shade50,
    //               backcolor: Color(0xff0E181A),
    //               frequency: 3000,
    //             ),
    //           ),
    //           Text(
    //             'Distance to glow zone :\n ${widget.distance_to_center.toInt()} meters',
    //             textAlign: TextAlign.center,
    //             style: new TextStyle(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.bold,
    //                 fontSize: 30,
    //                 letterSpacing: 0.8,
    //                 wordSpacing: 1,
    //                 fontFamily: 'Montserrat'),
    //           ),
    //           SizedBox(width: 10.0, height: 10.0),
    //           Tracker(
    //             color: Colors.white,
    //             frequency: 10000,
    //             current_Lat: widget.current_Lat,
    //             current_Lng: widget.current_Lnt,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
