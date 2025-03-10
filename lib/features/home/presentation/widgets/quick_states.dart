import 'package:flutter/material.dart';
import 'package:gps_attendance/features/home/presentation/widgets/state_row.dart';

class QuickStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StateRow(title: "Days Present This Month", value: "22/25"),
          StateRow(title: "Overtime Hours", value: "6.5"),
          StateRow(title: "Performance", value: "EXCELLENT"),
        ],
      ),
    );
  }
}
