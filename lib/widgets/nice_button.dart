import 'package:flutter/material.dart';

Widget niceButton({required String title, required VoidCallback onTap}) =>
    ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          Color.fromARGB(255, 26, 150, 177),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
