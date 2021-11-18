import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:glow2021v1/screens/black_screen.dart';
import 'package:glow2021v1/screens/green_screen.dart';
import 'package:glow2021v1/screens/red_screen.dart';
import 'package:lamp/lamp.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as distanceUtil;
import 'package:poly_geofence_service/poly_geofence_service.dart';

class GlowApp extends StatefulWidget {
  @override
  _GlowAppState createState() => _GlowAppState();
}

class _GlowAppState extends State<GlowApp> {
  // Green Zone Center : 51.447717, 5.456978
  // Pointer to center Location variable

  double _current_Lat = 0;
  double _current_Lng = 0;
  //Distance tracker
  num distance = 0;
  UserLocationStatus userLocationStatus = UserLocationStatus.outsideZone;

  final _streamController = StreamController<PolyGeofence>();

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
      interval: 500, // Time interval to check geofence status
      accuracy: 20, // geofencing error range in meters
      loiteringDelayMs: 6000000,
      statusChangeDelayMs: 1000,
      allowMockLocations: false,
      printDevLog: false);
  int zoneCounter = 0;
  // Create a [PolyGeofence] list.
  final _polyGeofenceList = <PolyGeofence>[
    PolyGeofence(
      id: 'Red Zone',
      data: {'Red'},
      polygon: <LatLng>[
        const LatLng(51.44798770469571, 5.453609218214037),
        const LatLng(51.44896434573987, 5.4549214178732495),
        const LatLng(51.4491214743131, 5.457018905186086),
        const LatLng(51.4466909356254, 5.460103445605499),
        const LatLng(51.446106101196065, 5.459479445643427),
      ],
    ),
    PolyGeofence(
      id: 'Green Zone',
      data: {'Green'},
      polygon: <LatLng>[
        const LatLng(51.447409255917215, 5.456023922597575),
        const LatLng(51.44849455555152, 5.456986835626296),
        const LatLng(51.44865168574167, 5.457440128912996),
        const LatLng(51.44764704614813, 5.458722224779638),
        const LatLng(51.44691152228507, 5.458016803854036),
      ],
    ),
  ];

  // This function is to be called when the geofence status is changed.
  Future<void> _onPolyGeofenceStatusChanged(PolyGeofence polyGeofence,
      PolyGeofenceStatus polyGeofenceStatus, Location location) async {
    //notion here...
  }

  num _calDistanceInMeter() {
    num edge_line_1 = distanceUtil.PolygonUtil.distanceToLine(
      distanceUtil.LatLng(_current_Lat, _current_Lng),
      distanceUtil.LatLng(51.447409255917215, 5.456023922597575),
      distanceUtil.LatLng(51.44849455555152, 5.456986835626296),
    );
    num edge_line_2 = distanceUtil.PolygonUtil.distanceToLine(
      distanceUtil.LatLng(_current_Lat, _current_Lng),
      distanceUtil.LatLng(51.44849455555152, 5.456986835626296),
      distanceUtil.LatLng(51.44865168574167, 5.457440128912996),
    );
    num edge_line_3 = distanceUtil.PolygonUtil.distanceToLine(
      distanceUtil.LatLng(_current_Lat, _current_Lng),
      distanceUtil.LatLng(51.44865168574167, 5.457440128912996),
      distanceUtil.LatLng(51.44764704614813, 5.458722224779638),
    );
    num edge_line_4 = distanceUtil.PolygonUtil.distanceToLine(
      distanceUtil.LatLng(_current_Lat, _current_Lng),
      distanceUtil.LatLng(51.44764704614813, 5.458722224779638),
      distanceUtil.LatLng(51.44691152228507, 5.458016803854036),
    );
    num edge_line_5 = distanceUtil.PolygonUtil.distanceToLine(
        distanceUtil.LatLng(_current_Lat, _current_Lng),
        distanceUtil.LatLng(51.44691152228507, 5.458016803854036),
        distanceUtil.LatLng(51.447409255917215, 5.456023922597575));
    num result = [
      edge_line_1,
      edge_line_2,
      edge_line_3,
      edge_line_4,
      edge_line_5
    ].reduce(min);
    return result;
  }

  // This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    //New location loaded, reset the offset for the direction
    UserLocationStatus result = UserLocationStatus.outsideZone;
    //Inside Red Zone ?
    if (_polyGeofenceList[0].status.toString() == 'PolyGeofenceStatus.ENTER' ||
        _polyGeofenceList[0].status.toString() == 'PolyGeofenceStatus.DWELL') {
      result = UserLocationStatus.insideRedZone;
    }
    //Inside Glow Zone ?
    if (_polyGeofenceList[1].status.toString() == 'PolyGeofenceStatus.ENTER' ||
        _polyGeofenceList[1].status.toString() == 'PolyGeofenceStatus.DWELL') {
      result = UserLocationStatus.insideGreenZone;
    }
    setState(() {
      if (this.mounted) {
        userLocationStatus = result;
        distance = _calDistanceInMeter();
        _current_Lat = location.latitude;
        _current_Lng = location.longitude;
      }
    });
  }

  // This function is to be called when a location services status change occurs
  // since the service was started.
  void _onLocationServicesStatusChanged(bool status) {
    print('isLocationServicesEnabled: $status');
  }

  // This function is used to handle errors that occur in the service.
  void _onError(error) {
    final errorCode = getErrorCodesFromError(error);
    if (errorCode == null) {
      print('Undefined error: $error');
      return;
    }
    print('ErrorCode: $errorCode');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _polyGeofenceService
          .addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
      _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
      _polyGeofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _polyGeofenceService.addStreamErrorListener(_onError);
      _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userLocationStatus == UserLocationStatus.insideGreenZone) {
      // if (Lamp.hasLamp != null) {
      //   Lamp.turnOn();
      // }
      return new WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // A widget used when you want to start a foreground task when trying to minimize or close the app.
          // Declare on top of the [Scaffold] widget.
          home: GreenZoneScreen(
              current_Lat: _current_Lat,
              current_Lnt: _current_Lng,
              distance_to_center: distance), // Black Scr
        ),
      );
    }
    if (userLocationStatus == UserLocationStatus.insideRedZone) {
      // if (Lamp.hasLamp != null) {
      //   Lamp.turnOff();
      // }
      return new WillPopScope(
        onWillPop: () async => false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // A widget used when you want to start a foreground task when trying to minimize or close the app.
          // Declare on top of the [Scaffold] widget.
          home: RedZoneScreen(
              current_Lat: _current_Lat,
              current_Lnt: _current_Lng,
              distance_to_center: distance), // Black Scr
        ),
      );
    }
    // if (Lamp.hasLamp != null) {
    //   Lamp.turnOff();
    // }
    return new WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // A widget used when you want to start a foreground task when trying to minimize or close the app.
        // Declare on top of the [Scaffold] widget.
        home: BlackZoneScreen(
            current_Lat: _current_Lat,
            current_Lnt: _current_Lng,
            distance_to_center: distance), // Black Scr
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

enum UserLocationStatus {
  outsideZone,
  insideRedZone,
  insideGreenZone,
}
