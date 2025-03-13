import 'package:flutter/material.dart';
import 'package:gps_attendance/features/home/presentation/widgets/dot_text.dart';
import 'package:gps_attendance/features/home/presentation/widgets/state_row.dart';
import 'colored_card.dart'; // Import the reusable widget

class ShiftDetailsCard extends StatelessWidget {
  const ShiftDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredCard(
      borderColor: Colors.orange.shade300,
      backgroundColor: Colors.orange.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShiftColumn("Current Shift", "08:00 AM - 05:00 PM"),
              _buildShiftColumn("Upcoming Shift", "Thursday, 08:00 AM"),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Break Times",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          DotText(firstText: "Morning", secondText: "10:30 AM (15 mins)"),
          DotText(firstText: "Lunch", secondText: "12:30 PM (45 mins)"),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Overtime Eligible",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.teal,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "YES",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftColumn(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            time,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade700),
          ),
        ),
      ],
    );
  }
}
