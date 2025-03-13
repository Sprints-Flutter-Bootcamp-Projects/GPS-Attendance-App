import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CustomCard({
    super.key,
    required this.child,
    this.borderColor = Colors.black12,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(12.0),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: child,
    );
  }
}
