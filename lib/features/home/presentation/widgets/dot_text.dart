import 'package:flutter/material.dart';

class DotText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final TextStyle? style;

  const DotText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$firstText • $secondText",
      style: style ?? const TextStyle(fontSize: 14, color: Colors.black54),
    );
  }
}
