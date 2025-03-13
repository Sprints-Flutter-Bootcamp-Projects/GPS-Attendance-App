import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeofenceResult {
  final bool isWithinGeofence;
  final LatLng userLatLng;

  GeofenceResult({required this.isWithinGeofence, required this.userLatLng});
}
