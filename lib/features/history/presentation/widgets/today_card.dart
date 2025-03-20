import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/cubits/attendance_status/attendancestatus_cubit.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/features/history/presentation/cubits/today_stats_cubit.dart';
import 'package:gps_attendance/widgets/ui_components/chip.dart';
import 'package:intl/intl.dart';

class TodayCard extends StatelessWidget {
  const TodayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today", style: Theme.of(context).textTheme.displayLarge),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primary, width: 1.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => sl<TodayStatsCubit>(),
                ),
                BlocProvider(
                  create: (context) => sl<AttendanceStatusCubit>(),
                ),
              ],
              child: BlocBuilder<AttendanceStatusCubit, AttendanceStatusState>(
                builder: (context, attendanceState) {
                  return Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMEd().format(DateTime.now()),
                          style: Theme.of(context).textTheme.displaySmall),
                      Row(
                        children: [
                          CustomChip(text: "Software Development"),
                        ],
                      ),
                      attendanceState is AttendanceStatusUserCheckedOut
                          ? Column(
                              children: [
                                CheckInOutRow(
                                    label: "Check-In",
                                    time: attendanceState.checkInTime),
                                CheckInOutRow(
                                  label: "Check-Out",
                                  time: attendanceState.checkOutTime,
                                  isCheckOut: true,
                                ),
                              ],
                            )
                          : attendanceState is AttendanceStatusUserCheckedIn
                              ? CheckInOutRow(
                                  label: "Check-In",
                                  time: attendanceState.checkInTime)
                              : SizedBox.shrink(),
                      BlocBuilder<TodayStatsCubit, TodayStatsState>(
                        builder: (context, todayState) {
                          if (todayState is TodayStatsLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (todayState is TodayStatsLoaded) {
                            return Column(
                              spacing: 5,
                              children: [
                                Row(
                                  spacing: 4,
                                  children: [
                                    CustomChip(
                                      text:
                                          "Total Hours \u2022 ${todayState.totalHours}",
                                      backgroundColor:
                                          Theme.of(context).splashColor,
                                    ),
                                    CustomChip(
                                        text:
                                            "Overtime \u2022 ${todayState.overtime}",
                                        backgroundColor:
                                            Theme.of(context).splashColor),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomChip(
                                        text: todayState.isRegular
                                            ? "Status \u2022 Regular Hours"
                                            : "Status \u2022 Overtime",
                                        backgroundColor:
                                            Theme.of(context).splashColor),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Center(
                                child: Text('Failed to get Today\'s Stats'));
                          }
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CheckInOutRow extends StatelessWidget {
  final String label;
  final String time;
  final bool isCheckOut;
  const CheckInOutRow({
    super.key,
    required this.label,
    required this.time,
    this.isCheckOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        CustomChip(
          text: time,
          padding: 3,
          fontSize: 9,
          backgroundColor: isCheckOut
              ? Theme.of(context).splashColor.withAlpha(25)
              : Theme.of(context).primaryColor.withAlpha(25),
          foregroundColor: isCheckOut
              ? Theme.of(context).splashColor
              : Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
