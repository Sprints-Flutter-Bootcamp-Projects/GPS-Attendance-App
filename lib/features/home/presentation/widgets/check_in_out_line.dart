import 'package:flutter/material.dart';

class CheckInOutWidget extends StatelessWidget {
  final String label;
  final String time;

  const CheckInOutWidget({super.key, required this.label, this.time = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label • $time",
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }
}
