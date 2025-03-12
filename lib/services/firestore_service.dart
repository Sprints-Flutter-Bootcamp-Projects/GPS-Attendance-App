import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gps_attendance/core/models/geofence_settings.dart';
import 'package:gps_attendance/core/models/work_zone.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateGeofenceSettings(GeofenceSettings settings) async {
    await _firestore
        .collection('settings')
        .doc('geofence')
        .set(settings.toMap());
  }

  Future<GeofenceSettings> getGeofenceSettings() async {
    final doc = await _firestore.collection('settings').doc('geofence').get();
    if (doc.exists) {
      return GeofenceSettings.fromMap(doc.data()!);
    } else {
      return GeofenceSettings(
        radius: 1,
      );
    }
  }

  Future<void> addWorkZone(WorkZone workZone) async {
    await _firestore
        .collection('workZones')
        .doc(workZone.id)
        .set(workZone.toMap());
  }

  Future<List<WorkZone>> getWorkZones() async {
    final querySnapshot = await _firestore.collection('workZones').get();
    return querySnapshot.docs
        .map((doc) => WorkZone.fromMap(doc.data()))
        .toList();
  }

  Future<void> assignWorkZoneToUser(String userId, String workZoneId) async {
    await _firestore.collection('users').doc(userId).update({
      'workZoneId': workZoneId,
    });
  }

  Future<String?> getUserWorkZoneId(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    return doc['workZoneId'] as String?;
  }

  Stream<QuerySnapshot> getAttendanceHistory() {
    final userId = _auth.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('attendance')
        .orderBy('checkIn', descending: true)
        .snapshots();
  }

  // Fetch all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final querySnapshot = await _firestore.collection('users').get();
    return querySnapshot.docs.map((doc) {
      return {
        'uid': doc.id,
        'email': doc['email'],
        'role': doc['role'],
      };
    }).toList();
  }

  // Fetch all attendance records (for moderators and admins)
  Stream<QuerySnapshot> getAllAttendanceRecords() {
    return _firestore
        .collectionGroup('attendance')
        .orderBy('checkIn', descending: true)
        .snapshots();
  }

  // Fetch attendance records for a specific user (for regular users)
  Stream<QuerySnapshot> getUserAttendanceRecords({required String userId}) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('attendance')
        .orderBy('checkIn', descending: true)
        .snapshots();
  }

  // Delete a record (for admins)
  Future<void> deleteAttendanceRecord(String userId, String recordId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('attendance')
        .doc(recordId)
        .delete();
  }

  Future<int> getPresentDaysInCurrentMonth({required int month}) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('attendance')
          .where('checkIn',
              isGreaterThanOrEqualTo:
                  Timestamp.fromDate(DateTime(2025, month, 1)))
          .where('checkIn',
              isLessThanOrEqualTo:
                  Timestamp.fromDate(DateTime(2025, month + 1, 0)))
          .get();

      final presentDays = snapshot.docs
          .map((doc) => (doc['checkIn'] as Timestamp).toDate().day)
          .toSet()
          .length;

      return presentDays;
    } catch (e) {
      rethrow;
    }
  }
}
