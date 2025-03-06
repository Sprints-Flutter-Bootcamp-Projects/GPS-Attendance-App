import 'package:geolocator/geolocator.dart';

class GeofenceSettings {
  final double radius; // Geofence radius in degrees
  final int distanceFilter; // Distance filter in meters
  final LocationAccuracy accuracy; // Location accuracy

  GeofenceSettings({
    required this.radius,
    required this.distanceFilter,
    required this.accuracy,
  });

  factory GeofenceSettings.fromMap(Map<String, dynamic> data) {
    return GeofenceSettings(
      radius: data['radius'] as double,
      distanceFilter: data['distanceFilter'] as int,
      accuracy: parseAccuracy(data['accuracy'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radius': radius,
      'distanceFilter': distanceFilter,
      'accuracy': accuracy.toString(),
    };
  }

  static LocationAccuracy parseAccuracy(String accuracy) {
    switch (accuracy) {
      case 'LocationAccuracy.low':
        return LocationAccuracy.low;
      case 'LocationAccuracy.medium':
        return LocationAccuracy.medium;
      case 'LocationAccuracy.high':
        return LocationAccuracy.high;
      case 'LocationAccuracy.best':
        return LocationAccuracy.best;
      default:
        return LocationAccuracy.best;
    }
  }
}
