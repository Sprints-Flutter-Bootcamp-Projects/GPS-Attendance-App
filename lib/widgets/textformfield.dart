import 'package:flutter/material.dart';

// Custom TextFormField widget
class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validation logic

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText, // Dynamically passed label text
        floatingLabelStyle: TextStyle(
          color: Color(0xFF1A96B1), // Color of the label when focused
          fontSize: 14, // Optional: Adjust font size
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          borderSide: const BorderSide(
            color: Color(0xFFC5C6CC), // Default border color
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Color(0xFF1A96B1), // Border color when focused
            width: 2.0,
          ),
        ),
      ),
      validator: validator, // Custom validation logic
    );
  }
}
