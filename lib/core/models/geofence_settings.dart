class GeofenceSettings {
  final double radius; // Geofence radius in degrees

  GeofenceSettings({
    required this.radius,
  });

  factory GeofenceSettings.fromMap(Map<String, dynamic> data) {
    return GeofenceSettings(
      radius: data['radius'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'radius': radius,
    };
  }
}
