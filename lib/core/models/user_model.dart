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

  AttendanceRecord({
    required this.checkIn,
    required this.checkOut,
    required this.userId,
  });

  factory AttendanceRecord.fromMap(Map<String, dynamic> map) {
    return AttendanceRecord(
      checkIn: (map['checkIn'] as Timestamp).toDate(),
      checkOut: (map['checkOut'] as Timestamp).toDate(),
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'checkIn': Timestamp.fromDate(checkIn),
      'checkOut': checkOut != null ? Timestamp.fromDate(checkOut!) : null,
      'userId': userId,
    };
  }
}
