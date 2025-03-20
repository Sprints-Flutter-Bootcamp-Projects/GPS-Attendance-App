import 'package:flutter/material.dart';

Widget accountCard({required bool employee, required VoidCallback onTap}) {
  // Define properties based on account type
  final cardColor = employee ? Color.fromARGB(255, 26, 150, 177) : Colors.white;

  final textColor = employee ? Colors.white : Color.fromARGB(255, 26, 150, 177);

  final icon = employee
      ? const Icon(Icons.person, size: 150, color: Colors.white)
      : Icon(Icons.business_center_rounded, size: 150, color: textColor);

  final title = employee ? "Employee Account" : "Manager Account";

  final description = employee
      ? "For individual users, employees who are working for a certain company or employer."
      : "For managers or employers.";

  final buttonText = employee ? "Join as Employee" : "Join as Manager";

  return Container(
    padding: const EdgeInsets.all(0.0),
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(title, style: TextStyle(color: textColor)),
            const SizedBox(height: 10),
            Text(description, style: TextStyle(color: textColor)),
            const SizedBox(height: 10),
            OutlinedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                side: WidgetStateProperty.all(
                  BorderSide(color: textColor),
                ), // Set outline color to white
              ),
              onPressed: onTap,
              child: Text(buttonText, style: TextStyle(color: textColor)),
            ),
          ],
        ),
      ),
    ),
  );
}
