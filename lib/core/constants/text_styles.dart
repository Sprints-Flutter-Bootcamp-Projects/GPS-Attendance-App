import 'package:flutter/material.dart';

class TrackSyncTextStyles {
  // Headings
  static TextStyle h1({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle h2({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle h3({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w800,
      color: color,
    );
  }

  static TextStyle h4({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle h5({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  // Body text
  static TextStyle bodyXL({Color color = Colors.black}) {
    return TextStyle(fontFamily: 'Inter', fontSize: 18, color: color);
  }

  static TextStyle bodyL({Color color = Colors.black}) {
    return TextStyle(fontFamily: 'Inter', fontSize: 16, color: color);
  }

  static TextStyle bodyM({Color color = Colors.black}) {
    return TextStyle(fontFamily: 'Inter', fontSize: 14, color: color);
  }

  static TextStyle bodyS({Color color = Colors.black}) {
    return TextStyle(fontFamily: 'Inter', fontSize: 12, color: color);
  }

  static TextStyle bodyXS({Color color = Colors.black}) {
    return TextStyle(fontFamily: 'Inter', fontSize: 10, color: color);
  }

  // Action text
  static TextStyle actionL({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle actionM({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  static TextStyle actionS({Color color = Colors.black}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  // Caption text
  static TextStyle caption({Color color = Colors.black54}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: 10,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }
}
