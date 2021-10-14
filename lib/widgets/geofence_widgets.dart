import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glow2021v1/bloc/geofence_bloc.dart';
import 'package:glow2021v1/screens/black_screen.dart';
import 'package:glow2021v1/screens/green_screen.dart';
import 'package:glow2021v1/screens/red_screen.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as distanceUtil;
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:rxdart/rxdart.dart';

class GlowApp extends StatefulWidget {
  @override
  _GlowAppState createState() => _GlowAppState();
}

class _GlowAppState extends State<GlowApp> {
  // Green Zone Center : 51.447717, 5.456978
  // Pointer to center Location variable
  final double _center_Lat = 51.447717;
  final double _center_Lng = 5.456978;

  double _current_Lat = 0;
  double _current_Lng = 0;
  //Distance tracker
  num distance = 0;

  //final _streamController = StreamController<PolyGeofence>();
  StreamController<PolyGeofence> _streamController = BehaviorSubject();
  GeofenceBloc _geofenceBloc = GeofenceBloc();

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
        const LatLng(51.448316, 5.454186),
        const LatLng(51.44916416512275, 5.4557594211801685),
        const LatLng(51.44855570734108, 5.456918135510549),
        const LatLng(51.44733208090987, 5.455662861711249),
      ],
    ),
    PolyGeofence(
      id: 'Red Zone',
      data: {'Red'},
      polygon: <LatLng>[
        const LatLng(51.44679915203191, 5.458106851466598),
        const LatLng(51.44754702425743, 5.458841798246701),
        const LatLng(51.446713244048304, 5.459993281684838),
        const LatLng(51.44649741675963, 5.459585287867803),
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
    zoneCounter++;
    if (polyGeofence.status == PolyGeofenceStatus.ENTER) {
      _geofenceBloc.add(UpdateGeofenceEvent(polyGeofence.id));
      zoneCounter = zoneCounter - 1;
    } else {
      if (zoneCounter == 3) {
        _geofenceBloc.add(UpdateGeofenceEvent('black'));
      }
    }
    if (zoneCounter == 4) {
      zoneCounter = 3;
      _geofenceBloc.add(UpdateGeofenceEvent('black'));
    }
    if (polyGeofence.id == 'Green Zone') {
      if (zoneCounter == 4) {
        zoneCounter = 2;
      }
      print('Green Zone zoneCounter= ' + zoneCounter.toString());
    }
  }

  num _calDistanceInMeter() {
    num result = distanceUtil.SphericalUtil.computeDistanceBetween(
        distanceUtil.LatLng(_center_Lat, _center_Lng),
        distanceUtil.LatLng(_current_Lat, _current_Lng));
    return result;
  }

  // This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    //New location loaded, reset the offset for the direction
    setState(() {
      if (this.mounted) {
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
    return new WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        // A widget used when you want to start a foreground task when trying to minimize or close the app.
        // Declare on top of the [Scaffold] widget.
        home: WillStartForegroundTask(
            onWillStart: () {
              // You can add a foreground task start condition.
              return _polyGeofenceService.isRunningService;
            },
            androidNotificationOptions: AndroidNotificationOptions(
              channelId: 'geofence_service_notification_channel',
              channelName: 'Geofence Service Notification',
              channelDescription:
                  'This notification appears when the geofence service is running in the background.',
              channelImportance: NotificationChannelImportance.LOW,
              priority: NotificationPriority.LOW,
            ),
            iosNotificationOptions:
                IOSNotificationOptions(showNotification: true, playSound: true),
            notificationTitle: 'Geofence Service is running',
            notificationText: 'Tap to return to the app',
            child: BlocBuilder(
                bloc: _geofenceBloc,
                builder: (context, state) {
                  if (state is CurrentGeofence) {
                    if (state.id == null || state.id == 'black') {
                      return BlackZoneScreen(
                          current_Lat: _current_Lat,
                          current_Lnt: _current_Lng,
                          distance_to_center: distance); // Black Screen
                    } else if (state.id == 'Green Zone') {
                      return Stack(children: [
                        GreenZoneScreen(
                            current_Lat: _current_Lat,
                            current_Lnt: _current_Lng,
                            distance_to_center: distance)
                      ]);
                    } else {
                      return RedZoneScreen(
                          current_Lat: _current_Lat,
                          current_Lnt: _current_Lng,
                          distance_to_center: distance);
                    } // Red Screen
                  } else //Error or Empty Screen...
                    return Scaffold();
                })),
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _geofenceBloc.close();
    super.dispose();
  }
}
