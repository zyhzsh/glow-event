import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:geofence_service/models/geofence.dart';
import 'package:glow2021v1/InitialData.dart';
import 'package:glow2021v1/screens/black_screen.dart';
import 'package:glow2021v1/screens/green_screen.dart';
import 'package:glow2021v1/screens/red_screen.dart';
import 'package:lamp/lamp.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as distanceUtil;

class GlowApp extends StatefulWidget {
  GlowApp({Key? key}) : super(key: key);
  @override
  _GlowAppState createState() => _GlowAppState();
}

class _GlowAppState extends State<GlowApp> {
  //User Current Location
  double _current_Lat = InitialData.initial_Lat;
  double _current_Lng = InitialData.initial_Lng;
  //Distance tracker
  num distance = 0;

  //Initial Location Status is GreenZone
  UserLocationStatus userLocationStatus = UserLocationStatus.insideGreenZone;

  final _streamController = StreamController<Geofence>();

// Create a [GeofenceService] instance and set options.
  final _geofenceService = GeofenceService.instance.setup(
      interval: 500,
      accuracy: 20,
      loiteringDelayMs: 30000,
      statusChangeDelayMs: 1000,
      useActivityRecognition: false,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: GeofenceRadiusSortType.DESC);
  // Create a [Geofence] list.
  final _geofenceList = <Geofence>[
    Geofence(
      id: 'RedZone',
      latitude: InitialData.initial_Lat,
      longitude: InitialData.initial_Lng,
      radius: [
        GeofenceRadius(id: 'red_zone_radius_126m', length: 126.16),
      ],
    ),
    Geofence(
      id: 'GreenZone',
      latitude: InitialData.initial_Lat,
      longitude: InitialData.initial_Lng,
      radius: [
        GeofenceRadius(id: 'green_zone_radius_71m', length: 71.36),
      ],
    ),
  ];

  // This function is to be called when the geofence status is changed.
  Future<void> _onGeofenceStatusChanged(Geofence polyGeofence,
      GeofenceStatus polyGeofenceStatus, Location location) async {
    //notion here...
  }

//This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    //New location loaded, reset the offset for the direction
    UserLocationStatus result = UserLocationStatus.outsideZone;
    //Check Distance if null,then = 0
    num distance_to_center = _geofenceList[1].remainingDistance?.toInt() ?? 0;

    //Inside Red Zone ?
    if (_geofenceList[0].status.toString() == 'GeofenceStatus.ENTER' ||
        _geofenceList[0].status.toString() == 'GeofenceStatus.DWELL') {
      result = UserLocationStatus.insideRedZone;
    }

    //Inside Green Zone ?
    if (_geofenceList[1].status.toString() == 'GeofenceStatus.ENTER' ||
        _geofenceList[1].status.toString() == 'GeofenceStatus.DWELL') {
      result = UserLocationStatus.insideGreenZone;
    }
    setState(() {
      if (this.mounted) {
        userLocationStatus = result;
        _current_Lat = location.latitude;
        _current_Lng = location.longitude;
        distance = distance_to_center;
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
      _geofenceService.addLocationChangeListener(_onLocationChanged);
      _geofenceService.addLocationServicesStatusChangeListener(
          _onLocationServicesStatusChanged);
      _geofenceService.addStreamErrorListener(_onError);
      _geofenceService.start(_geofenceList).catchError(_onError);
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
