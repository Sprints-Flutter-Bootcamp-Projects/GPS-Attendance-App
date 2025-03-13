import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/features/history/presentation/widgets/calendar_widgets.dart';
import 'package:gps_attendance/features/history/presentation/widgets/quick_stats_card.dart';
import 'package:gps_attendance/features/history/presentation/widgets/this_month_card.dart';
import 'package:gps_attendance/features/history/presentation/widgets/today_card.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HistoryPage extends StatelessWidget {
  static const String routeName = '/history';
  HistoryPage({super.key});
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: BlocProvider(
        create: (context) => sl<MonthStatsCubit>(),
        child: ListView(
          children: [
            QuickStatsCard(),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppCalendar(
                source: <Meeting>[
                  Meeting('Meeting', DateTime.now(), DateTime.now(),
                      Colors.blue, false),
                ],
                controller: calendarController,
              ),
            ),
            Divider(),
            TodayCard(),
            Divider(),
            ThisMonthCard(),
          ],
        ),
      ),
    );
  }
}
