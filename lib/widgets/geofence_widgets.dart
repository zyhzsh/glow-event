import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geofence_service/geofence_service.dart';
import 'package:geofence_service/models/geofence.dart';
import 'package:glow2021v1/screens/black_screen.dart';
import 'package:glow2021v1/screens/green_screen.dart';
import 'package:glow2021v1/screens/red_screen.dart';
import 'package:lamp/lamp.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as distanceUtil;

class GlowApp extends StatefulWidget {
  @override
  _GlowAppState createState() => _GlowAppState();
}

class _GlowAppState extends State<GlowApp> {
  // Green Zone Center : 51.447717, 5.456978
  // Pointer to center Location variable

  double _current_Lat = 0;
  double _current_Lng = 0;

  //Center Location

  static double _center_Lat = 1.1;
  static double _center_Lng = 1.1;

  //Distance tracker
  num distance = 0;

  UserLocationStatus userLocationStatus = UserLocationStatus.insideGreenZone;

  final _streamController = StreamController<Geofence>();

// Create a [GeofenceService] instance and set options.
  final _geofenceService = GeofenceService.instance.setup(
      interval: 5000,
      accuracy: 100,
      loiteringDelayMs: 60000,
      statusChangeDelayMs: 10000,
      useActivityRecognition: true,
      allowMockLocations: false,
      printDevLog: false,
      geofenceRadiusSortType: GeofenceRadiusSortType.DESC);
  // Create a [Geofence] list.
  final _geofenceList = <Geofence>[
    Geofence(
      id: 'RedZone',
      latitude: _center_Lat,
      longitude: _center_Lng,
      radius: [
        GeofenceRadius(id: 'red_zone_radius_126m', length: 126.16),
      ],
    ),
    Geofence(
      id: 'GreenZone',
      latitude: _center_Lat,
      longitude: _center_Lng,
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

  // Calculate distance between between geolocation
  num _calDistanceInMeter() {
    num distanceBetweenPoints =
        distanceUtil.SphericalUtil.computeDistanceBetween(
            distanceUtil.LatLng(_current_Lat, _current_Lng),
            distanceUtil.LatLng(_center_Lat, _center_Lng));
    return distanceBetweenPoints;
  }

//This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    //New location loaded, reset the offset for the direction
    UserLocationStatus result = UserLocationStatus.outsideZone;
    //Inside Red Zone ?
    if (_geofenceList[0].status.toString() == 'PolyGeofenceStatus.ENTER' ||
        _geofenceList[0].status.toString() == 'PolyGeofenceStatus.DWELL') {
      result = UserLocationStatus.insideRedZone;
    }
    //Inside Green Zone ?
    if (_geofenceList[1].status.toString() == 'PolyGeofenceStatus.ENTER' ||
        _geofenceList[1].status.toString() == 'PolyGeofenceStatus.DWELL') {
      result = UserLocationStatus.insideGreenZone;
    }
    setState(() {
      if (this.mounted) {
        userLocationStatus = result;
        _current_Lat = location.latitude;
        _current_Lng = location.longitude;
        distance = _calDistanceInMeter();
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

  // // This function is to be called when the location has changed.
  // void _onLocationChanged(Location location) {
  //   //New location loaded, reset the offset for the direction
  //   UserLocationStatus result = UserLocationStatus.outsideZone;
  //   //Inside Red Zone ?
  //   if (_polyGeofenceList[0].status.toString() == 'PolyGeofenceStatus.ENTER' ||
  //       _polyGeofenceList[0].status.toString() == 'PolyGeofenceStatus.DWELL') {
  //     result = UserLocationStatus.insideRedZone;
  //   }
  //   //Inside Glow Zone ?
  //   if (_polyGeofenceList[1].status.toString() == 'PolyGeofenceStatus.ENTER' ||
  //       _polyGeofenceList[1].status.toString() == 'PolyGeofenceStatus.DWELL') {
  //     result = UserLocationStatus.insideGreenZone;
  //   }
  //   setState(() {
  //     if (this.mounted) {
  //       userLocationStatus = result;
  //       distance = _calDistanceInMeter();
  //       _current_Lat = location.latitude;
  //       _current_Lng = location.longitude;
  //     }
  //   });
  // }
  //
  // // This function is to be called when a location services status change occurs
  // // since the service was started.
  // void _onLocationServicesStatusChanged(bool status) {
  //   print('isLocationServicesEnabled: $status');
  // }
  //
  // // This function is used to handle errors that occur in the service.
  // void _onError(error) {
  //   final errorCode = getErrorCodesFromError(error);
  //   if (errorCode == null) {
  //     print('Undefined error: $error');
  //     return;
  //   }
  //   print('ErrorCode: $errorCode');
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) {
  //     _polyGeofenceService
  //         .addPolyGeofenceStatusChangeListener(_onPolyGeofenceStatusChanged);
  //     _polyGeofenceService.addLocationChangeListener(_onLocationChanged);
  //     _polyGeofenceService.addLocationServicesStatusChangeListener(
  //         _onLocationServicesStatusChanged);
  //     _polyGeofenceService.addStreamErrorListener(_onError);
  //     _polyGeofenceService.start(_polyGeofenceList).catchError(_onError);
  //   });
  // }

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
