import 'package:flutter/material.dart';
import 'package:glow2021v1/tools/resize_tool.dart';

class Information extends StatefulWidget {
  String content = "Black";

  Information({Key? key, this.content = "Black"}) : super(key: key);

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    HYSizeFit.initialize(context);
    if (widget.content == 'Black') {
      return SafeArea(
        child: Container(
            child: ListView(
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                  top: HYSizeFit.setRpx(10), right: HYSizeFit.setWidth(100)),
              height: HYSizeFit.setWidth(20),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, size: HYSizeFit.setWidth(20)),
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: HYSizeFit.setWidth(30),
                  left: HYSizeFit.setWidth(30),
                  right: HYSizeFit.setWidth(30),
                  bottom: HYSizeFit.setWidth(30)),
              child: Text(
                "Uitleg applicatie",
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(50),
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: HYSizeFit.setWidth(30), right: HYSizeFit.setWidth(30)),
              child: Text(
                'Deze app brengt je naar de Nederlandse voetafdruk.\n\n' +
                    'De voetafdruk van 5 hectare die Nederlanders gebruiken om te leven. \n\n' +
                    'Als we eerlijk delen met de rest van de wereld gebruiken we 1,6 hectare. \n\n' +
                    'Dat kan door duurzaam samen te leven met de natuur.',
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(40),
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
            ),
          ],
        )),
      );
    }
    if (widget.content == 'Green') {
      return SafeArea(
        child: Container(
            child: ListView(
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                  top: HYSizeFit.setRpx(10), right: HYSizeFit.setWidth(100)),
              height: HYSizeFit.setWidth(20),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, size: HYSizeFit.setWidth(20)),
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: HYSizeFit.setWidth(30),
                  left: HYSizeFit.setWidth(30),
                  right: HYSizeFit.setWidth(30),
                  bottom: HYSizeFit.setWidth(30)),
              child: Text(
                "Gefeliciteerd!",
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(50),
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: HYSizeFit.setWidth(30), right: HYSizeFit.setWidth(30)),
              child: Text(
                'Je staat nu in de groene \n' +
                    ' voetafdruk van 1.6 hectare\n\n' +
                    ' zoveel oppervlakte kunnen we gebruiken om te leven\n\n' +
                    ' Dit kan als we duurzaam samenleven met de natuur',
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(40),
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
            ),
          ],
        )),
      );
    }
    if (widget.content == 'Red') {
      return SafeArea(
        child: Container(
            child: ListView(
          children: [
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                  top: HYSizeFit.setRpx(10), right: HYSizeFit.setWidth(100)),
              height: HYSizeFit.setWidth(20),
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close, size: HYSizeFit.setWidth(20)),
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: HYSizeFit.setWidth(30),
                  left: HYSizeFit.setWidth(30),
                  right: HYSizeFit.setWidth(30),
                  bottom: HYSizeFit.setWidth(30)),
              child: Text(
                "Oeps...",
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(50),
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: HYSizeFit.setWidth(30), right: HYSizeFit.setWidth(30)),
              child: Text(
                'Je bent in de rode voetafdruk van 5 hectare\n\n'
                'Zoveel oppervlakte gebruikt de gemiddelde Nederlander om te leven\n\n'
                'Als we eerlijk met de wereld delen, kunnen we maar 1.6 hectare gebruiken',
                style: TextStyle(
                    fontSize: HYSizeFit.setRpx(40),
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.none,
                    color: Colors.white),
              ),
            ),
          ],
        )),
      );
    }
    //Return empty container.
    return Container();
  }
}
