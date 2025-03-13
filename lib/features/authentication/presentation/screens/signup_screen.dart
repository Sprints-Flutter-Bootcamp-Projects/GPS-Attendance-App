import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/company_department.dart';

import 'package:gps_attendance/widgets/custom_appbar.dart';
import 'package:gps_attendance/widgets/nice_button.dart';
import 'package:gps_attendance/widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Register"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthSuccess) {
              Navigator.pop(context); // Close loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("Signup successful!"),
                    backgroundColor: Colors.green),
              );
              Navigator.pop(context);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => CompleteDetailsPage()),
              // );
            } else if (state is AuthFailure) {
              Navigator.pop(context); // Close loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Full Name",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              CustomTextField(
                  controller: _fullNameController,
                  label: "Full Name",
                  labelIcon: Icons.person,
                  obsecureText: false,
                  isPassword: false,
                  validator: (value) {}),
              Text("Email Address",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  labelIcon: Icons.email,
                  obsecureText: false,
                  isPassword: false,
                  validator: (value) {}),
              Text("Password",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              CustomTextField(
                  controller: _passwordController,
                  label: "Password",
                  labelIcon: Icons.lock,
                  obsecureText: true,
                  isPassword: true,
                  validator: (value) {}),
              CustomTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  labelIcon: Icons.lock,
                  obsecureText: true,
                  isPassword: true,
                  validator: (value) {}),
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
                    child: Text(
                        "I've read and agree with the Terms and Conditions and the Privacy Policy.",
                        style: TextStyle(fontSize: 12, color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _agreeToTerms
                  ? niceButton(
                      title: "Create Account",
                      onTap: () {
                        if (_passwordController.text ==
                            _confirmPasswordController.text) {
                          context.read<AuthBloc>().add(
                                SignUpRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  fullName: _fullNameController.text.trim(),
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Passwords do not match"),
                              backgroundColor: Colors.red));
                        }
                      })
                  : Text("Accept terms and conditions to sign up",
                      style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
