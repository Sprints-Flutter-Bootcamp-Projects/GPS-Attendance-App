class WorkZone {
  final String id;
  final String name;
  final double latitude;
  final double longitude;

  WorkZone({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory WorkZone.fromMap(Map<String, dynamic> data) {
    return WorkZone(
      id: data['id'] as String,
      name: data['name'] as String,
      latitude: data['latitude'] as double,
      longitude: data['longitude'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
