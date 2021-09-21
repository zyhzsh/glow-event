import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poly_geofence_service/poly_geofence_service.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc/geofence_bloc.dart';

void main() => runApp(ExampleApp());

class ExampleApp extends StatefulWidget {
  @override
  _ExampleAppState createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  //final _streamController = StreamController<PolyGeofence>();
  StreamController<PolyGeofence> _streamController = BehaviorSubject();
  GeofenceBloc _geofenceBloc = GeofenceBloc();

  // Create a [PolyGeofenceService] instance and set options.
  final _polyGeofenceService = PolyGeofenceService.instance.setup(
      interval: 5000, // Time interval to check geofence status
      accuracy: 100, // geofencing error range in meters
      loiteringDelayMs: 6000000,
      statusChangeDelayMs: 1000,
      allowMockLocations: false,
      printDevLog: false);

  int zoneCounter = 0;
  // Create a [PolyGeofence] list.
  final _polyGeofenceList = <PolyGeofence>[
    PolyGeofence(id: 'Red Zone',
      data: {'Red'},
      polygon: <LatLng>[
        const LatLng(51.448316, 5.454186),
        const LatLng(51.44916416512275, 5.4557594211801685),
        const LatLng(51.44855570734108, 5.456918135510549),
        const LatLng(51.44733208090987, 5.455662861711249),
      ],
    ),
    PolyGeofence(id: 'Red Zone',
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
    print('polyGeofence: ${polyGeofence.toJson()}');
    zoneCounter++;
    print('current zone:'+ polyGeofence.id.toString());
    print('counter'+ zoneCounter.toString());
    if (polyGeofence.status == PolyGeofenceStatus.ENTER) {
        _geofenceBloc.add(UpdateGeofenceEvent(polyGeofence.id));
        zoneCounter = zoneCounter -1;
    }
    else{
      if(zoneCounter == 3){
        _geofenceBloc.add(UpdateGeofenceEvent('black'));
      }
    }
    if(zoneCounter == 4){
      zoneCounter = 3;
      _geofenceBloc.add(UpdateGeofenceEvent('black'));
    }
    if(polyGeofence.id == 'Green Zone'){
      //zoneCounter = 0;
      if(zoneCounter == 4){
        zoneCounter = 2;
      }
      print('Green Zone zoneCounter= ' + zoneCounter.toString());
    }
  }

  // This function is to be called when the location has changed.
  void _onLocationChanged(Location location) {
    //print('location: ${location.toJson()}');
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
    return MaterialApp(
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
          builder: (context,state) {
              if(state is CurrentGeofence){
              if( state.id == null || state.id == 'black')
              {
                return Scaffold(backgroundColor: Colors.black);
              }
              else{
                  return Scaffold( backgroundColor: state.id == 'Green Zone'? Colors.green : Colors.red);}
              }
              else return Scaffold();
          }
        )
      ),
    );
  }

  @override
  void dispose() {
    _streamController.close();
    _geofenceBloc.close();
    super.dispose();
  }

  Widget _buildContentView() {
    return StreamBuilder<PolyGeofence>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        final updatedDateTime = DateTime.now();

        final content = snapshot.data?.toJson().toString() ?? '';
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: [
            Text('•\t\tPolyGeofence (updated: $updatedDateTime)'),
            SizedBox(height: 10.0),
            Text(content),
          ],
        );
      },
    );
  }
}
