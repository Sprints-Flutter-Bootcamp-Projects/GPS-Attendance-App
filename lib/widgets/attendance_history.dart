// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gps_attendance/services/firestore_service.dart';

// class AttendanceHistory extends StatelessWidget {
//   final String? userId; // Pass the userId for filtering
//   final bool showAllRecords; // Whether to show all records or just the user's

//   const AttendanceHistory({
//     super.key,
//     this.userId,
//     this.showAllRecords = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final firestoreService = FirestoreService();

//     return StreamBuilder<QuerySnapshot>(
//       stream: showAllRecords
//           ? firestoreService.getAllAttendanceRecords()
//           : firestoreService.getUserAttendanceRecords(userId!),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No attendance records found.'));
//         }

//         final attendanceRecords = snapshot.data!.docs;
//         return ListView.builder(
//           itemCount: attendanceRecords.length,
//           itemBuilder: (context, index) {
//             final record = attendanceRecords[index];
//             final type = record['type'] as String? ?? 'Unknown';
//             final userName = record['userName'] as String? ?? 'Unknown User';
//             final timestamp = record['timestamp'] as Timestamp?;

//             if (timestamp == null) {
//               return ListTile(
//                 title: Text('$userName - $type'),
//                 subtitle: const Text('Invalid timestamp'),
//               );
//             }

//             return ListTile(
//               title: Text('$userName - $type'),
//               subtitle: Text(timestamp.toDate().toString()),
//             );
//           },
//         );
//       },
//     );
//   }
// }
