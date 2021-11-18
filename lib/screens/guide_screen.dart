import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';
import 'package:glow2021v1/widgets/geofence_widgets.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import '../InitialData.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Container(
            height: HYSizeFit.setHeight(2),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(22.0),
                    bottomLeft: Radius.circular(22.0)),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/guide-page.png'))),
          ),
          Stack(
            children: [
              Positioned(
                top: HYSizeFit.setHeight(18),
                left: HYSizeFit.setWidth(300),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: HYSizeFit.setHeight(8.4),
                left: HYSizeFit.setWidth(50),
                child: Container(
                  child: Text('Om zo',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HYSizeFit.setRpx(46),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Positioned(
                top: HYSizeFit.setHeight(6),
                left: HYSizeFit.setWidth(50),
                child: Container(
                  child: Text('De \nBeste \nErvaring \nTe \nCreëren',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: HYSizeFit.setHeight(24),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600)),
                ),
              ),
              Positioned(
                top: HYSizeFit.setHeight(2),
                left: HYSizeFit.setWidth(50),
                child: Container(
                  width: HYSizeFit.setRpx(700),
                  height: HYSizeFit.setRpx(800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: HYSizeFit.setHeight(30)),
                        child: Text('Uw gegevens',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: HYSizeFit.setRpx(40),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600)),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Om de app zo nauwkeurig mogelijk te houden, maken vragen wij toegang tot uw locatie die ook gecontroleerd wordt op de achtergrond. De instellingen hiervan kunt u altijd later nog aanpassen, maar voor de beste ervaring is het belangrijk dit aan te zetten. Naast de gegevens van uw locatie zal de app ook de zaklamp activeren wanneer u in de groene zone bent. Wanneer u dit niet wilt kunt u het altijd uitzetten.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: HYSizeFit.setRpx(30),
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300)),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: HYSizeFit.setHeight(60)),
                                child: SizedBox(
                                  width: HYSizeFit.setRpx(370),
                                  child: TextButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(23.26)),
                                      padding: EdgeInsets.only(
                                          left: HYSizeFit.setWidth(50),
                                          right: HYSizeFit.setWidth(50),
                                          top: HYSizeFit.setHeight(60),
                                          bottom: HYSizeFit.setHeight(60)),
                                    ),
                                    onPressed: () => _openGlowApp(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: Text(
                                          'Beginnen ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: HYSizeFit.setRpx(40),
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w500),
                                        )),
                                        Icon(
                                          Icons.arrow_forward_outlined,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _openGlowApp(BuildContext context) async {
    var location_permission = await Permission.location.status;
    var flash_light = await Permission.camera.status;
    Location location = new Location();
    if (location_permission.isDenied ||
        flash_light.isDenied ||
        location_permission.isPermanentlyDenied ||
        flash_light.isPermanentlyDenied ||
        location_permission.isRestricted ||
        flash_light.isRestricted) {
      await Permission.location.request();
      await Permission.camera.request();
    }
    location_permission = await Permission.location.status;
    flash_light = await Permission.camera.status;
    if (location_permission.isGranted && flash_light.isGranted) {
      LocationData _locationData = await location.getLocation();
      InitialData.initializeLocationData(_locationData.latitude!.toDouble(),
          _locationData.longitude!.toDouble());
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => new GlowApp()));
    }
  }
}
