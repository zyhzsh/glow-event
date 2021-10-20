import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';
import 'package:glow2021v1/widgets/information_widget.dart';
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
      floatingActionButton: IconButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (context) => FractionallySizedBox(
                    heightFactor: 0.8,
                    child: Information(
                      content: 'Red',
                    ),
                  ));
        },
        icon: Image.asset('images/information_icon.png'),
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
                  'Je bent momenteel in de \n rode zone (5 hectare) ',
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
    );
  }
}
