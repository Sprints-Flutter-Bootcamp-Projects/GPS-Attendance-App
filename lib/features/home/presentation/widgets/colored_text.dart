import 'package:flutter/material.dart';

class ColoredText extends StatelessWidget {
  final String text;
  final Color colorBackground;
  final Color colorText;
  const ColoredText(
      {super.key,
      required this.text,
      required this.colorBackground,
      required this.colorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12, color: colorText, fontWeight: FontWeight.bold),
      ),
    );
  }
}
