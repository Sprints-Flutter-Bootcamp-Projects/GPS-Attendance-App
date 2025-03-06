import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_attendance/services/auth_service.dart';
import '../services/location_service.dart';

class GeofenceMap extends StatefulWidget {
  const GeofenceMap({super.key});

  @override
  State<GeofenceMap> createState() => _GeofenceMapState();
}

class _GeofenceMapState extends State<GeofenceMap> {
  late GoogleMapController _mapController;
  LatLng _userLocation = const LatLng(30.0444, 31.2357); // Default to Cairo
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    // _startLocationTracking();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _startLocationTracking() {
    final locationService = LocationService();
    locationService.getCurrentLocationStream().listen((Position position) {
      setState(() {
        _userLocation = LatLng(position.latitude, position.longitude);
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('user'),
            position: _userLocation,
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
      });

      // Optionally, move the camera to the user's location
      _mapController.animateCamera(
        CameraUpdate.newLatLng(_userLocation),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      initialCameraPosition: CameraPosition(
        target: _userLocation,
        zoom: 13,
      ),
      markers: _markers,
    );
  }
}
