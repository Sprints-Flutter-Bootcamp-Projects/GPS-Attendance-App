import 'package:flutter/material.dart';
import 'package:gps_attendance/features/history/presentation/widgets/attendance_status_chip.dart';
import 'package:gps_attendance/widgets/ui_components/chip.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAttendanceHistory extends StatefulWidget {
  static const String routeName = '/user_attendance_history';
  final String? userId;
  final String? fullName;

  const UserAttendanceHistory({super.key, this.userId, this.fullName});

  @override
  State<UserAttendanceHistory> createState() => _UserAttendanceHistoryState();
}

class _UserAttendanceHistoryState extends State<UserAttendanceHistory> {
  final DateFormat _dayFormatter = DateFormat('yyyy-MM-dd');
  DateTime _startDate = DateTime.now().copyWith(day: 1);
  DateTime _endDate = DateTime.now();
  final DateFormat _dateRangeFormat = DateFormat('MMM d, yyyy');

  Future<Map<String, DocumentSnapshot>> _getAttendanceData() async {
    final query = await FirebaseFirestore.instance
        .collection(
            'users/${widget.userId ?? FirebaseAuth.instance.currentUser!.uid}/attendance')
        .where(FieldPath.documentId,
            isGreaterThanOrEqualTo: _dayFormatter.format(_startDate))
        .where(FieldPath.documentId,
            isLessThanOrEqualTo: _dayFormatter.format(_endDate))
        .get();

    return {for (var doc in query.docs) doc.id: doc};
  }

  List<DateTime> _getAllDatesInRange() {
    final days = _endDate.difference(_startDate).inDays + 1;
    return List.generate(days,
        (i) => DateTime(_startDate.year, _startDate.month, _startDate.day + i));
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final initialRange = DateTimeRange(start: _startDate, end: _endDate);

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
      initialDateRange: initialRange,
      fieldStartHintText: 'Start date',
      fieldEndHintText: 'End date',
      saveText: 'Select',
    );

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate =
            picked.end.isAfter(DateTime.now()) ? DateTime.now() : picked.end;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize to current day at 11:59AM
    _endDate = DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance History'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.fullName ??
                      FirebaseAuth.instance.currentUser!.displayName!,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.edit_calendar),
                  onPressed: () => _selectDateRange(context),
                  color: IconTheme.of(context).color,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${_dateRangeFormat.format(_startDate)} - ${_dateRangeFormat.format(_endDate)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: FutureBuilder<Map<String, DocumentSnapshot>>(
              future: _getAttendanceData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final attendanceData = snapshot.data ?? {};
                final allDates = _getAllDatesInRange();

                return ListView.builder(
                  itemCount: allDates.length,
                  itemBuilder: (context, index) {
                    final date = allDates[index];
                    final doc = attendanceData[_dayFormatter.format(date)];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _DayAttendanceTile(date: date, doc: doc),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DayAttendanceTile extends StatelessWidget {
  final DateTime date;
  final DocumentSnapshot? doc;
  const _DayAttendanceTile({required this.date, this.doc});

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat('E, MMM d').format(date);

    AttendanceStatusEnum status = AttendanceStatusEnum.absent;

    String timeRange = '--:-- : --:--';
    String duration = '0H 0M';

    if (doc != null) {
      final data = doc?.data() as Map<String, dynamic>;
      final checkIn = (data['checkIn'] as Timestamp).toDate();
      final checkOut = data['checkOut'] != null
          ? (data['checkOut'] as Timestamp).toDate()
          : null;

      timeRange = checkOut != null
          ? '${DateFormat('hh:mm a').format(checkIn)} : ${DateFormat('hh:mm a').format(checkOut)}'
          : '${DateFormat('hh:mm a').format(checkIn)} : --:--';

      if (checkOut != null) {
        final worked = checkOut.difference(checkIn);
        duration = '${worked.inHours}H ${worked.inMinutes.remainder(60)}M';

        status = worked.inHours > 8
            ? AttendanceStatusEnum.overtime
            : AttendanceStatusEnum.regular;
      } else {
        status = AttendanceStatusEnum.pending;
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateString,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomChip(text: timeRange),
              CustomChip(text: duration),
              AttendanceStatusChip(attendanceStatus: status),
            ],
          ),
        ],
      ),
    );
  }
}
