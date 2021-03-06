import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';
import 'package:glow2021v1/widgets/footprint_widgets.dart';
import 'package:glow2021v1/widgets/information_widget.dart';
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
    HYSizeFit.initialize(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton(
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Colors.black87,
              isScrollControlled: true,
              context: context,
              builder: (context) => FractionallySizedBox(
                    heightFactor: 0.92,
                    child: Information(
                      content: 'Black',
                    ),
                  ));
        },
        icon: Image.asset(
          'images/information_icon.png',
          height: 200,
          width: 200,
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment(1.0, -5),
                  end: Alignment(-1.0, 3),
                  colors: [Color(0xff141617), Color(0xff39444F)])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: HYSizeFit.setRpx(350),
                width: HYSizeFit.setRpx(350),
                child: PulseEffect_B(
                  glowColor: Colors.green.shade50,
                  backcolor: Color(0xff0E181A),
                  frequency: 3000,
                ),
              ),
              SizedBox(height: HYSizeFit.setRpx(20)),
              Text(
                'Volg de voetafdruk \n'
                'Afstand naar de groene zone:\n ${widget.distance_to_center.toInt()} meters',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: HYSizeFit.setRpx(40),
                    letterSpacing: 0.8,
                    wordSpacing: 1,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(width: 10.0, height: HYSizeFit.setRpx(100)),
              Tracker(
                color: Colors.white,
                frequency: 10000,
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
