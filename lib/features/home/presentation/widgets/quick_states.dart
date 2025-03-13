import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/features/home/presentation/widgets/state_row.dart';
import 'package:gps_attendance/widgets/warnings/snackbar.dart';

class QuickStats extends StatelessWidget {
  const QuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: BlocConsumer<MonthStatsCubit, MonthStatsState>(
        listener: (context, state) {
          if (state is MonthStatsError) {
            TrackSyncSnackbar.show(
                context, state.errorMessage, SnackbarType.error);
          }
        },
        builder: (context, state) {
          if (state is MonthStatsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MonthStatsLoaded) {
            int overtimeHour = state.userMonthStatsResult.totalOvertime.inHours;
            int overtimeMinutes = state
                .userMonthStatsResult.totalOvertime.inMinutes
                .remainder(60);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StateRow(
                    title: "Days Present This Month",
                    value: "${state.userMonthStatsResult.daysPresent}/25"),
                StateRow(
                    title: "Overtime Hours",
                    value: "${overtimeHour}H ${overtimeMinutes}M"),
                StateRow(title: "Performance", value: "EXCELLENT"),
              ],
            );
          } else {
            return Text('Failed to Fetch Data');
          }
        },
      ),
    );
  }
}
