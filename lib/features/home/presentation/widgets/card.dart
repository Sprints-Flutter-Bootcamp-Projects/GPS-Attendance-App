import 'package:flutter/material.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F4F9), // Light blue background
        borderRadius: BorderRadius.circular(12), // Rounded corners
        border: Border.all(
          color: const Color(0xFF0097A7), // Border color
          width: 1.5, // Border thickness
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Software Engineering",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Manager • Sarah Thompson",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const Text(
            "Contact • eng-support@techcorp.com",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0097A7), // Button color
              foregroundColor: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Button corners
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
