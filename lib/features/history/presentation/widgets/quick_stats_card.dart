import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/widgets/ui_components/chip.dart';
import 'package:gps_attendance/widgets/ui_components/warnings/snackbar.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MonthStatsCubit, MonthStatsState>(
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
          int overtimeMinutes =
              state.userMonthStatsResult.totalOvertime.inMinutes.remainder(60);

          int totalHours = state.userMonthStatsResult.totalHours.inHours;
          int remainderMinutes =
              state.userMonthStatsResult.totalHours.inMinutes.remainder(60);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Quick Stats",
                    style: Theme.of(context).textTheme.displayLarge),
                QuickStatsRow(
                    label: "Days Present This Month ",
                    value: "${state.userMonthStatsResult.daysPresent}/25"),
                QuickStatsRow(label: "Performance ", value: "Excellent"),
                Row(
                  spacing: 8,
                  children: [
                    CustomChip(
                        text:
                            "Total Hours \u2022 ${totalHours}H ${remainderMinutes}M"),
                    CustomChip(
                        text:
                            "Overtime \u2022 ${overtimeHour}H ${overtimeMinutes}M"),
                  ],
                )
              ],
            ),
          );
        } else {
          return Text('Failed to Fetch Data');
        }
      },
    );
  }
}

class QuickStatsRow extends StatelessWidget {
  final String label;
  final String value;
  const QuickStatsRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        CustomChip(
          text: value,
          padding: 3,
          fontSize: 9,
          backgroundColor: Theme.of(context).primaryColor.withAlpha(25),
          foregroundColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
