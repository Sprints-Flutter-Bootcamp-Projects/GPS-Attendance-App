import 'package:flutter/material.dart';

class ColorOutBtn extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onTap;

  const ColorOutBtn(
      {super.key, required this.color, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color, // Custom text & border color
        side: BorderSide(
          color: color, // Custom border color
          width: 2, // Border thickness
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 24, vertical: 12), // Button padding
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600, // Semi-bold text
        ),
      ),
    );
  }
}
