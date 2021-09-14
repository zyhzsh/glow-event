part of 'geofence_bloc.dart';

@immutable
abstract class GeofenceState {}

class CurrentGeofence extends GeofenceState {
  final String? status;

  CurrentGeofence(this.status);
}