import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/authentication/screens/company&department.dart';
import 'package:gps_attendance/features/authentication/widgets/page_desc.dart';
import 'package:gps_attendance/widgets/appbar.dart';
import 'package:gps_attendance/widgets/nice_button.dart';
import 'package:gps_attendance/widgets/text_form_field.dart';
import '../../../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Register"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageDesc(
                title: "Sign up",
                description: "Create an account to get started"),
            Text(
              "Full Name",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            CustomTextField(
              controller: _fullNameController,
              label: "Full Name",
              labelIcon: Icons.person,
              obsecureText: false,
              isPassword: false,
              validator: (value) {},
            ),
            Text(
              "Email Address",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            CustomTextField(
              controller: _emailController,
              label: "Email",
              labelIcon: Icons.email,
              obsecureText: false,
              isPassword: false,
              validator: (value) {},
            ),
            Text(
              "Password",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            CustomTextField(
              controller: _passwordController,
              label: "Password",
              labelIcon: Icons.lock,
              obsecureText: true,
              isPassword: true,
              validator: (value) {},
            ),
            CustomTextField(
              controller: _confirmPasswordController,
              label: "Confirm Password",
              labelIcon: Icons.lock,
              obsecureText: true,
              isPassword: true,
              validator: (value) {},
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (bool? value) {
                    setState(() {
                      _agreeToTerms = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to Terms and Conditions page if needed
                    },
                    child: Text(
                      "I've read and agree with the Terms and Conditions and the Privacy Policy.",
                      style: TextStyle(
                          fontSize: 12, color: AppColors.primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _agreeToTerms
                ? niceButton(
                    title: "Create Account",
                    onTap: () async {
                      await authService.signUp(
                        _emailController.text,
                        _passwordController.text,
                        'user', // Default role for new users
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompleteDetailsPage()),
                        );
                      // if (context.mounted) {
                      //   Navigator.pop(context); // Go back to the login screen
                      // }
                    })
                : Text(
                    "Accept terms and conditions to sign up",
                    style: TextStyle(color: Colors.red),
                  ),
          ],
        ),
      ),
    );
  }
}
