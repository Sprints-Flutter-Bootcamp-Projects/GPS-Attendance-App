import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance/core/models/work_zone.dart';
import 'package:gps_attendance/features/attendance/datatypes/geofence_result.dart';
import 'package:gps_attendance/services/firestore_service.dart';
import 'package:intl/intl.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<WorkZone?> getUserWorkZone() async {
    final userId = _auth.currentUser!.uid;
    final workZoneId = await FirestoreService().getUserWorkZoneId(userId);
    if (workZoneId != null) {
      final querySnapshot = await _firestore
          .collection('workZones')
          .where('id', isEqualTo: workZoneId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return WorkZone.fromMap(querySnapshot.docs.first.data());
      }
    }
    return null;
  }

  Future<GeofenceResult?> isUserWithinGeofence() async {
    final workZone = await getUserWorkZone();

    if (workZone == null) return null;

    try {
      Position position = await getCurrentUserPosition();

      double userLat = position.latitude;
      double userLng = position.longitude;

      bool isWithinGeofence = await _isWithinGeofence(
          userLat, userLng, workZone.latitude, workZone.longitude);

      return GeofenceResult(
        isWithinGeofence: isWithinGeofence,
        userLatLng: LatLng(userLat, userLng),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> _isWithinGeofence(double userLat, double userLng,
      double workZoneLat, double workZoneLng) async {
    final settings = await FirestoreService().getGeofenceSettings();

    double radius = settings.radius;

    return ((workZoneLat - userLat).abs() < radius &&
        (workZoneLng - userLng).abs() < radius);
  }

  Future<bool> checkIn() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    final todayDoc = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('attendance')
        .doc(_dateFormatter.format(DateTime.now()));

    try {
      return _firestore.runTransaction<bool>((transaction) async {
        final doc = await transaction.get(todayDoc);

        // Prevent duplicate check-ins
        if (doc.exists && doc.data()?.containsKey('checkIn') == true) {
          return false;
        }

        transaction.set(
          todayDoc,
          {
            'checkIn': FieldValue.serverTimestamp(),
            'userId': user.uid,
            'status': 'Checked In',
            'date': _dateFormatter.format(DateTime.now())
          },
          SetOptions(merge: true),
        );

        return true;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkOut() async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User is not authenticated');

    final todayDoc = _firestore
        .collection('users')
        .doc(user.uid)
        .collection('attendance')
        .doc(_dateFormatter.format(DateTime.now()));

    try {
      return await _firestore.runTransaction<bool>((transaction) async {
        final doc = await transaction.get(todayDoc);

        // Validate check-in existence
        if (!doc.exists || doc.data()?['checkIn'] == null) {
          throw Exception('Check-in required before checkout');
        }

        // Prevent duplicate checkouts
        if (doc.data()?['checkOut'] != null) {
          return false;
        }

        transaction.update(todayDoc, {
          'checkOut': FieldValue.serverTimestamp(),
          'status': 'Checked Out'
        });

        return true;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<Position> getCurrentUserPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    // Get the current position with a timeout
    try {
      return await Geolocator.getCurrentPosition()
          .timeout(const Duration(seconds: 10)); // Add a 10-second timeout
    } on TimeoutException catch (e) {
      return Future.error('Failed to get location: ${e.message}');
    } catch (e) {
      return Future.error('Failed to get location: $e');
    }
  }
}
