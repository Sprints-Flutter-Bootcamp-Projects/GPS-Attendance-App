import 'package:flutter/material.dart';
import 'package:gps_attendance/core/constants/colors.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final double padding;
  final double fontSize;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData? icon;
  final bool isBordered;

  const CustomChip({
    super.key,
    required this.text,
    this.padding = 4.0,
    this.fontSize = 10.0,
    this.backgroundColor = TrackSyncColors.highlightDarkest,
    this.foregroundColor = TrackSyncColors.highlightLightest,
    this.icon,
    this.isBordered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding * 2, vertical: padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        border: isBordered
            ? Border.all(
                color: foregroundColor,
                width: 1.5,
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: foregroundColor,
              size: fontSize * 1.5,
            ),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              color: foregroundColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
