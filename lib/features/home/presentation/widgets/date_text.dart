import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateText extends StatelessWidget {
  final DateTime date;

  const DateText({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat.yMMMMd().format(date); // Example: June 13, 2024

    return Text(
      formattedDate,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );
  }
}
