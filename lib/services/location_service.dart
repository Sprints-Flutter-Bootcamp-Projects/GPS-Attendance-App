// import 'dart:async';

// import 'package:geolocator/geolocator.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../models/work_zone.dart';
// import '../services/firestore_service.dart';

// class LocationService {
//   static final LocationService _instance = LocationService._internal();
//   factory LocationService() => _instance;
//   LocationService._internal();

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<WorkZone?> getUserWorkZone() async {
//     final userId = _auth.currentUser!.uid;
//     final workZoneId = await FirestoreService().getUserWorkZoneId(userId);
//     if (workZoneId != null) {
//       final querySnapshot = await _firestore
//           .collection('workZones')
//           .where('id', isEqualTo: 'workZone1')
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         return WorkZone.fromMap(querySnapshot.docs.first.data());
//       }
//     }
//     return null;
//   }

//   Future<bool> isUserWithinGeofence() async {
//     final workZone = await getUserWorkZone();

//     if (workZone == null) return false;

//     try {
//       Position position = await getCurrentUserPosition();

//       double userLat = position.latitude;
//       double userLng = position.longitude;

//       print(_isWithinGeofence(
//           userLat, userLng, workZone.latitude, workZone.longitude));
//       return _isWithinGeofence(
//           userLat, userLng, workZone.latitude, workZone.longitude);
//     } on Exception catch (e) {
//       print('Error checking geofence: $e');
//       return false;
//     }
//   }

//   Future<bool> _isWithinGeofence(double userLat, double userLng,
//       double workZoneLat, double workZoneLng) async {
//     final settings = await FirestoreService().getGeofenceSettings();
//     double radius = settings.radius;

//     return ((workZoneLat - userLat).abs() < radius &&
//         (workZoneLng - userLng).abs() < radius);
//   }

//   Future<void> manualCheckIn() async {
//     bool isWithinGeofence = await isUserWithinGeofence();

//     if (isWithinGeofence) {
//       final user = _auth.currentUser;
//       if (user != null) {
//         final userDoc =
//             await _firestore.collection('users').doc(user.uid).get();
//         final userName = userDoc['email']; // Use email as the user name

//         // Check if the user is already checked in
//         if (userDoc['status'] == 'checked-out') {
//           await _firestore.collection('attendance').add({
//             'userId': user.uid,
//             'userName': userName,
//             'type': 'check-in',
//             'timestamp': DateTime.now(),
//           });

//           // Update user status to 'checked-in'
//           await _firestore.collection('users').doc(user.uid).update({
//             'status': 'checked-in',
//           });

//           print('Check-in recorded successfully');
//         } else {
//           print('User is already checked in.');
//         }
//       }
//     } else {
//       print('User is outside the geofence. Check-in not allowed.');
//     }
//   }

//   Future<void> manualCheckOut() async {
//     bool isWithinGeofence = await isUserWithinGeofence();
//     if (!isWithinGeofence) {
//       final user = _auth.currentUser;
//       if (user != null) {
//         final userDoc =
//             await _firestore.collection('users').doc(user.uid).get();
//         final userName = userDoc['email']; // Use email as the user name

//         // Check if the user is already checked out
//         if (userDoc['status'] == 'checked-in') {
//           await _firestore.collection('attendance').add({
//             'userId': user.uid,
//             'userName': userName,
//             'type': 'check-out',
//             'timestamp': DateTime.now(),
//           });

//           // Update user status to 'checked-out'
//           await _firestore.collection('users').doc(user.uid).update({
//             'status': 'checked-out',
//           });

//           print('Check-out recorded successfully');
//         } else {
//           print('User is already checked out.');
//         }
//       }
//     } else {
//       print('User is inside the geofence. Check-out not allowed.');
//     }
//   }

//   Stream<Position> getCurrentLocationStream() {
//     return Geolocator.getPositionStream(
//       locationSettings: LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10, // Update every 10 meters
//       ),
//     );
//   }

//   Future<Position> getCurrentUserPosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.

//     // Get the current position with a timeout
//     try {
//       return await Geolocator.getCurrentPosition()
//           .timeout(const Duration(seconds: 10)); // Add a 10-second timeout
//     } on TimeoutException catch (e) {
//       return Future.error('Failed to get location: ${e.message}');
//     } catch (e) {
//       return Future.error('Failed to get location: $e');
//     }
//   }
// }
