import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';
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
              'De Rode Voetafdruk',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Oeps… \n\nJe bent in de rode voetafdruk van 4.9 hectare, zoveel oppervlakte gebruikt de gemiddelde Nederlander om te leven, als wij eerlijk met de wereld delen, kunnen wij maar 1.6 hectare gebruiken.',
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Sluiten'),
                child: const Text('Sluiten'),
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

      //Back - up Options
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(1.0, -5),
                  end: Alignment(-1.0, 3),
                  colors: [Color(0xFFACACAC), Color(0xFFEC101A)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: HYSizeFit.setRpx(50), vertical: 10),
                child: Text(
                  'Je bent momenteel in de \n rode zone (4.9 hectare) ',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: HYSizeFit.setRpx(40),
                      letterSpacing: 0.8,
                      wordSpacing: 1,
                      fontFamily: 'Montserrat'),
                ),
              ),
              Container(
                height: HYSizeFit.setRpx(350),
                width: HYSizeFit.setRpx(350),
                // child: PulseEffect_A(
                //   count: 1,
                //   color: Colors.white,
                //   frequency: 2000,
                // )
                child: PulseEffect_B(
                  glowColor: Colors.red.shade50,
                  backcolor: Color(0xFFEC101A),
                  frequency: 3000,
                ),
              ),
              SizedBox(height: HYSizeFit.setRpx(20)),
              Text(
                ' Afstand naar de groene zone:\n ${widget.distance_to_center.toInt()} meters',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: HYSizeFit.setRpx(40),
                    letterSpacing: 0.8,
                    wordSpacing: 1,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 10.0, height: HYSizeFit.setRpx(30)),
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

      // body: Scaffold(
      //     backgroundColor: Color(0xFFEC101A),
      //     body: Stack(
      //       children: [
      //         Positioned(
      //           top: 370,
      //           left: 80,
      //           width: 250,
      //           height: 250,
      //           child: Row(
      //             children: [
      //               Expanded(
      //                   child: Align(
      //                 alignment: FractionalOffset.bottomCenter,
      //                 child: Container(
      //                   child: Tracker(
      //                     color: Colors.white,
      //                     frequency: (1000),
      //                     current_Lat: widget.current_Lat,
      //                     current_Lng: widget.current_Lnt,
      //                   ),
      //                   height: 120.0,
      //                 ),
      //               ))
      //             ],
      //           ),
      //         ),
      //         Positioned(
      //           top: 150,
      //           left: 80,
      //           width: 250,
      //           height: 250,
      //           child: Center(
      //             child: PulseEffect_B(
      //               glowColor: Colors.red.shade50,
      //               backcolor: Color(0xFFEC101A),
      //               frequency: 2000,
      //             ),
      //           ),
      //         ),
      //         Positioned(
      //             top: 420,
      //             left: 80,
      //             width: 270,
      //             height: 250,
      //             child: Text(
      //               "Distance to centre of the green zone: ${widget.distance_to_center.toInt()} metres",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold, height: 1.5, fontSize: 18),
      //             )),
      //       ],
      //     )),
    );
  }
}
