import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'geofence_event.dart';
part 'geofence_state.dart';

class GeofenceBloc extends Bloc<GeofenceEvent, GeofenceState> {
  String id = 'BLACK';
  GeofenceBloc() : super(CurrentGeofence("BLACK"));


  @override
  Stream<GeofenceState> mapEventToState(
      GeofenceEvent event,
      ) async* {
    switch (event.runtimeType) {
      case UpdateGeofenceEvent:
        yield* updateGeofence(event);
        break;
    }
  }

  Stream<GeofenceState> updateGeofence(event) async* {
    this.id = event.id;
    yield CurrentGeofence(event.id);
    print(id);
  }
}