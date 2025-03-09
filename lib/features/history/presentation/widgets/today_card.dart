import 'package:flutter/material.dart';
import 'package:gps_attendance/widgets/chip.dart';

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
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Thursday, March 25, 2025",
                    style: Theme.of(context).textTheme.displaySmall),
                SizedBox(height: 4),
                Row(
                  children: [
                    CustomChip(text: "Software Development"),
                  ],
                ),
                CheckInOutRow(label: "Check-In", time: "09:00 AM"),
                CheckInOutRow(
                  label: "Check-Out",
                  time: "06:00 PM",
                  isCheckOut: true,
                ),
                Row(
                  spacing: 4,
                  children: [
                    CustomChip(
                      text: "Total Hours \u2022 9H",
                      backgroundColor: Theme.of(context).splashColor,
                    ),
                    CustomChip(
                        text: "Overtime \u2022 1H",
                        backgroundColor: Theme.of(context).splashColor),
                  ],
                ),
                Row(
                  children: [
                    CustomChip(
                        text: "Status \u2022 Regular Hours",
                        backgroundColor: Theme.of(context).splashColor),
                  ],
                )
              ],
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
