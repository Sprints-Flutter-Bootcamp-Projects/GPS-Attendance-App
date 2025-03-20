import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gps_attendance/core/models/geofence_settings.dart';
import 'package:gps_attendance/core/models/user/user_model.dart';
import 'package:gps_attendance/core/models/work_zone.dart';
import 'package:gps_attendance/features/history/datatypes/user_month_stats.dart';
import 'package:gps_attendance/features/history/datatypes/user_today_stats.dart';
import 'package:intl/intl.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

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
        radius: 0.0002,
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

  Future<String?> getUserWorkZoneName(String userId) async {
    final workZoneId = await getUserWorkZoneId(userId);
    if (workZoneId == null) return null;

    final querySnapshot = await _firestore
        .collection('workZones')
        .where('id', isEqualTo: workZoneId)
        .get();
    final doc = querySnapshot.docs.first;
    return doc['name'] as String?;
  }

  Stream<QuerySnapshot> getCurrentUserAttendanceRecords() {
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

  // Fetch all attendance records
  Stream<QuerySnapshot> getAllUsersAttendanceRecords() {
    return _firestore
        .collectionGroup('attendance')
        .orderBy('checkIn', descending: true)
        .snapshots();
  }

  // Fetch attendance records for a specific user
  Stream<QuerySnapshot> getSpecificUserAttendanceRecords(
      {required String userId}) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('attendance')
        .orderBy('checkIn', descending: true)
        .snapshots();
  }

  // Delete a record (for admins)
  Future<void> deleteAttendanceRecord(String userId, DateTime day) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('attendance')
        .doc(_dateFormatter.format(day))
        .delete();
  }

  Future<AttendanceRecord?> getCurrentUserAttendanceRecordForDay(
      DateTime day) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('attendance')
          .doc(_dateFormatter.format(day))
          .get();

      if (!snapshot.exists) {
        return null; // Return null if document doesn't exist
      }

      final data = snapshot.data();

      if (data == null) return null;

      return AttendanceRecord.fromMap(data); // Return the AttendanceRecord
    } catch (e) {
      rethrow;
    }
  }

  Future<UserMonthStatsResult> getMonthStatsforUser({
    required String userId,
    required DateTime date,
  }) async {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(date.year, date.month + 1, 0);

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('attendance')
          .where('checkIn',
              isGreaterThanOrEqualTo: Timestamp.fromDate(startOfMonth))
          .where('checkIn', isLessThanOrEqualTo: Timestamp.fromDate(endOfMonth))
          .get();

      if (snapshot.docs.isEmpty) {
        return UserMonthStatsResult(
          daysPresent: 0,
          totalHours: Duration.zero,
          totalOvertime: Duration.zero,
        );
      }

      final int presentDays = snapshot.docs
          .map((doc) => (doc['checkIn'] as Timestamp).toDate().day)
          .toSet()
          .length;

      Duration totalWorkHours = Duration.zero;
      Duration totalOvertime = Duration.zero;
      Duration standardWorkDay = Duration(hours: 8);

      for (var doc in snapshot.docs) {
        final attendanceRecord = AttendanceRecord.fromMap(doc.data());
        if (attendanceRecord.status == 'Checked Out' &&
            attendanceRecord.checkOut != null) {
          final duration =
              attendanceRecord.checkOut!.difference(attendanceRecord.checkIn);
          totalWorkHours += duration;

          if (duration > standardWorkDay) {
            totalOvertime += duration - standardWorkDay; // Calculate overtime
          }
        }
      }

      return UserMonthStatsResult(
        daysPresent: presentDays,
        totalHours: totalWorkHours,
        totalOvertime: totalOvertime,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Duration?> getHoursWorkedforDay(DateTime day) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('attendance')
          .doc(_dateFormatter.format(day))
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data == null || data['status'] != 'Checked Out') {
          return null;
        }

        final Timestamp? checkInTimestamp = data['checkIn'] as Timestamp?;
        final Timestamp? checkOutTimestamp = data['checkOut'] as Timestamp?;

        if (checkInTimestamp == null || checkOutTimestamp == null) {
          return null;
        }

        final DateTime checkIn = checkInTimestamp.toDate();
        final DateTime checkOut = checkOutTimestamp.toDate();

        return checkOut.difference(checkIn);
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserTodayStatsResult> getTodayStats() async {
    DateTime now = DateTime.now();

    try {
      final todayRecord = await getCurrentUserAttendanceRecordForDay(now);

      Duration standardWorkDayHours = Duration(hours: 8);
      Duration? workingHoursToday = Duration.zero;
      Duration overtime = Duration.zero;

      if (todayRecord != null) {
        if (todayRecord.status == 'Checked Out' &&
            todayRecord.checkOut != null) {
          workingHoursToday =
              todayRecord.checkOut?.difference(todayRecord.checkIn);

          if (workingHoursToday! > standardWorkDayHours) {
            overtime = (workingHoursToday - standardWorkDayHours);
          }
        }
      }
      return UserTodayStatsResult(
        overTime: overtime,
        totalHours: workingHoursToday,
      );
    } catch (e) {
      rethrow;
    }
  }
}
