import 'package:flutter/material.dart';
import 'package:gps_attendance/widgets/chip.dart';

class QuickStatsCard extends StatelessWidget {
  const QuickStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Quick Stats", style: Theme.of(context).textTheme.displayLarge),
          QuickStatsRow(label: "Days Present This Month ", value: "22/25"),
          QuickStatsRow(label: "Performance ", value: "Excellent"),
          Row(
            spacing: 8,
            children: [
              CustomChip(text: "Total Hours \u2022 120H"),
              CustomChip(text: "Overtime \u2022 12H"),
            ],
          )
        ],
      ),
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
