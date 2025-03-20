import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/features/home/presentation/widgets/colored_card.dart';
import 'package:gps_attendance/widgets/common_widgets/attendance_history_list.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends StatelessWidget {
  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String today = _dateFormatter.format(DateTime.now());

    return Scaffold(
      appBar: AppBar(title: Text('Today\'s Attendance')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('attendance')
            .where('date', isEqualTo: today)
            .snapshots(),
        builder: (context, attendanceSnapshot) {
          if (attendanceSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (attendanceSnapshot.hasError) {
            return Center(child: Text('Error: ${attendanceSnapshot.error}'));
          }
          if (!attendanceSnapshot.hasData ||
              attendanceSnapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No attendance records found.'));
          }

          List<String> presentUserIds = attendanceSnapshot.data!.docs
              .map((doc) => doc['userId'] as String)
              .toList();

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, usersSnapshot) {
              if (!usersSnapshot.hasData) return CircularProgressIndicator();

              var allUsers = usersSnapshot.data!.docs;
              var presentUsers = allUsers
                  .where((user) => presentUserIds.contains(user.id))
                  .toList();
              var absentUsers = allUsers
                  .where((user) => !presentUserIds.contains(user.id))
                  .toList();

              return ListView(
                children: [
                  _TodayAttendanceSectionsWidget(
                    title: 'Present',
                    users: presentUsers,
                    attendanceDocs: attendanceSnapshot.data!.docs,
                  ),
                  _TodayAttendanceSectionsWidget(
                    title: 'Absent',
                    users: absentUsers,
                    attendanceDocs: null,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _TodayAttendanceSectionsWidget extends StatelessWidget {
  final String title;
  final List<QueryDocumentSnapshot> users;
  final List<QueryDocumentSnapshot>? attendanceDocs;

  const _TodayAttendanceSectionsWidget({
    required this.title,
    required this.users,
    this.attendanceDocs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            var user = users[index];
            var attendance = attendanceDocs?.firstWhere(
              (doc) => doc['userId'] == user.id,
            );

            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ColoredCard(
                backgroundColor: TrackSyncColors.highlightLightest,
                padding: EdgeInsets.all(0),
                child: ListTile(
                  title: Text(
                    user['fullName'],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  subtitle: Text(
                    '${user['email']}\n${user['department']} - ${user['title']}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      attendance != null
                          ? _AttendanceTimeWidget(
                              attendanceDocSnapshot: attendance)
                          : SizedBox.shrink(),
                      Icon(Icons.keyboard_arrow_right_outlined)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserAttendanceHistory(
                          fullName: user['fullName'],
                          userId: user.id,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _AttendanceTimeWidget extends StatelessWidget {
  final QueryDocumentSnapshot attendanceDocSnapshot;
  const _AttendanceTimeWidget({required this.attendanceDocSnapshot});

  @override
  Widget build(BuildContext context) {
    var data = attendanceDocSnapshot.data() as Map<String, dynamic>;
    var checkIn = data['checkIn'] as Timestamp;
    Timestamp? checkOut;

    if (data.containsKey('checkOut')) {
      checkOut = data['checkOut'] as Timestamp?;
    }

    var format = DateFormat('hh:mm a');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Check-in: ${format.format(checkIn.toDate())}'),
        if (checkOut != null)
          Text('Check-out: ${format.format(checkOut.toDate())}'),
      ],
    );
  }
}
