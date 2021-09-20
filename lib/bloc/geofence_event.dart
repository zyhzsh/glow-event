part of 'geofence_bloc.dart';

@immutable
abstract class GeofenceEvent {}

class UpdateGeofenceEvent extends GeofenceEvent {
  final String id;
  UpdateGeofenceEvent(this.id);
}