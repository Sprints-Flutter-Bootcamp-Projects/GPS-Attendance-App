import 'package:flutter/material.dart';

class CustomModal extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final Color? iconColor;
  final List<Widget>? actions;

  const CustomModal(
      {super.key,
      required this.title,
      this.message,
      this.icon,
      this.iconColor,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      icon: icon != null ? Icon(icon, color: iconColor, size: 62) : null,
      title: Center(
          child: Text(title, style: Theme.of(context).textTheme.displayLarge)),
      content: message != null ? Text(message!) : null,
      actions: actions,
    );
  }
}
