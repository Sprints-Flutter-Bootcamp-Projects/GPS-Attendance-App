import 'package:flutter/material.dart';

Widget niceButton({required String title, required VoidCallback onTap}) =>
    Container(
      padding: const EdgeInsets.all(0.0),
      // margin: const EdgeInsets.only(bottom: 12.0, left: 12.0, right: 12.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(
              Color.fromARGB(255, 26, 150, 177),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
