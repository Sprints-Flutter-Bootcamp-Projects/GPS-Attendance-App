import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/features/history/presentation/widgets/calendar_widgets.dart';
import 'package:gps_attendance/features/history/presentation/widgets/quick_stats_card.dart';
import 'package:gps_attendance/features/history/presentation/widgets/today_card.dart';
import 'package:gps_attendance/widgets/common_widgets/attendance_history_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PersonalHistoryTab extends StatefulWidget {
  const PersonalHistoryTab({super.key});

  @override
  State<PersonalHistoryTab> createState() => _PersonalHistoryTabState();
}

class _PersonalHistoryTabState extends State<PersonalHistoryTab> {
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MonthStatsCubit>(),
      child: ListView(
        children: [
          QuickStatsCard(),
          Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppCalendar(
              source: <Meeting>[
                Meeting('Meeting', DateTime.now(), DateTime.now(), Colors.blue,
                    false),
              ],
              controller: calendarController,
            ),
          ),
          Divider(),
          TodayCard(),
          Divider(),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: UserAttendanceHistory()),
        ],
      ),
    );
  }
}
