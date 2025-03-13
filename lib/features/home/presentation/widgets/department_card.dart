import 'package:flutter/material.dart';
import 'package:gps_attendance/features/home/presentation/widgets/colored_card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/dot_text.dart';

class DepartmentCard extends StatelessWidget {
  final String departmentName;
  final String leadPosition;
  final String leadName;
  final String contactInfo;

  const DepartmentCard(
      {super.key,
      required this.departmentName,
      required this.leadPosition,
      required this.leadName,
      required this.contactInfo});

  @override
  Widget build(BuildContext context) {
    return ColoredCard(
      backgroundColor: const Color(0xFFE3F4F9),
      borderColor: const Color(0xFF0097A7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            departmentName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          DotText(firstText: leadPosition, secondText: leadName),
          DotText(firstText: "Contact", secondText: contactInfo),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0097A7),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            label: const Text("Switch Department"),
          ),
        ],
      ),
    );
  }
}
