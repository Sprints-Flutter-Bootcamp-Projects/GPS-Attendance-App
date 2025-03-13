import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String department;
  final String role;
  final String workZoneId;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.department,
    required this.role,
    required this.workZoneId,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      fullName: data['fullName'],
      email: data['email'],
      department: data['department'],
      role: data['role'],
      workZoneId: data['workZoneId'],
    );
  }
}

class AttendanceRecord {
  final DateTime checkIn;
  final DateTime? checkOut;
  final String userId;
  final String status;

  AttendanceRecord({
    required this.checkIn,
    required this.checkOut,
    required this.userId,
    required this.status,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
        checkIn: (map['checkIn'] as Timestamp).toDate(),
        checkOut: map['checkOut'] != null
            ? (map['checkOut'] as Timestamp).toDate()
            : null,
        userId: map['userId'] ?? '',
        status: map['status'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'checkIn': Timestamp.fromDate(checkIn),
      'checkOut': checkOut != null ? Timestamp.fromDate(checkOut!) : null,
      'userId': userId,
      'status': status,
    };
  }
}
