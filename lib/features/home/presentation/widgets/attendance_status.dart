import 'package:flutter/material.dart';

class AttendanceStatus extends StatelessWidget {
  final String status;

  const AttendanceStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, color: Colors.black),
        children: [
          const TextSpan(
            text: "Attendance Status • ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: status,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _getStatusColor(status),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "checked in":
        return Colors.green;
      case "checked out":
        return Colors.red;
      case "pending":
        return Colors.orange;
      default:
        return Colors.black;
    }
  }
}
