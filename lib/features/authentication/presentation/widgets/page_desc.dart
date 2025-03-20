import 'package:flutter/material.dart';

class PageDesc extends StatelessWidget {
  final String title;
  final String description;

  const PageDesc({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.centerLeft, // Align content to start
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: Color(0xFF71727A)),
          ),
        ],
      ),
    );
  }
}
