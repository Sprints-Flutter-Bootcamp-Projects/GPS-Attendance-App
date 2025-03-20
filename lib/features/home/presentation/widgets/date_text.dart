import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateText extends StatelessWidget {
  final DateTime date;

  const DateText({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat.yMMMEd().format(date); // Example: June 13, 2024

    return Text(
      formattedDate,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}
