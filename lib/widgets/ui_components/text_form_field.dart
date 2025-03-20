import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData? labelIcon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool obsecureText;

  const CustomTextField(
      {super.key,
      required this.controller,
      required this.label,
      this.labelIcon,
      this.obsecureText = false,
      this.validator,
      this.isPassword = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  IconData? suffixIcon = Icons.visibility_off_outlined;
  late bool _obsecureText;

  void switchVisibility() {
    _obsecureText = !_obsecureText;
    suffixIcon = _obsecureText
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    setState(() {});
  }

  @override
  void initState() {
    _obsecureText = widget.obsecureText;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color myFocusColor = AppColors.primaryColor;
    Color myIconColor = AppColors.primaryColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? InkWell(
                  child: Icon(suffixIcon),
                  onTap: () => switchVisibility(),
                )
              : null,
          labelText: widget.label,
          hintText: 'Enter your ${widget.label.toLowerCase()}',
          focusColor: myFocusColor,
          prefixIcon: Icon(
            widget.labelIcon,
            color: myIconColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: myFocusColor,
            ),
          ),
        ),
        obscureText: _obsecureText,
        validator: widget.validator,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
