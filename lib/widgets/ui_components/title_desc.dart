import 'package:flutter/material.dart';

class TitleDesc extends StatelessWidget {
  final String title;
  final String? description; // Make description nullable

  const TitleDesc({
    super.key,
    required this.title,
    this.description, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          if (description != null) ...[
            // Only show if description is provided
            const SizedBox(height: 4),
            Text(
              description!,
              style: const TextStyle(fontSize: 12, color: Color(0xFF71727A)),
            ),
          ],
        ],
      ),
    );
  }
}
