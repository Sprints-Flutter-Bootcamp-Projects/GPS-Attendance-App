import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/widgets/ui_components/custom_appbar.dart';
import 'package:gps_attendance/widgets/ui_components/nice_button.dart';
import 'package:gps_attendance/widgets/ui_components/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup_screen';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _agreeToTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                    behavior: SnackBarBehavior.floating,
                    content: Text("Signup successful!"),
                    backgroundColor: Colors.green),
              );
              Navigator.pop(context);
            } else if (state is AuthFailure) {
              Navigator.pop(context); // Close loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),
                CustomTextField(
                  controller: _fullNameController,
                  label: "Full Name",
                  labelIcon: Icons.person,
                  obsecureText: false,
                  isPassword: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }

                    return null;
                  },
                ),
                CustomTextField(
                  controller: _emailController,
                  label: "Email",
                  labelIcon: Icons.email,
                  obsecureText: false,
                  isPassword: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _passwordController,
                  label: "Password",
                  labelIcon: Icons.lock,
                  obsecureText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  labelIcon: Icons.lock,
                  obsecureText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
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
                      child: Text(
                          "I've read and agree with the Terms and Conditions and the Privacy Policy.",
                          style: TextStyle(fontSize: 12, color: Colors.blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _agreeToTerms
                    ? Flexible(
                        child: niceButton(
                            title: "Create Account",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignUpRequested(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        fullName:
                                            _fullNameController.text.trim(),
                                      ),
                                    );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Please Enter Valid Data"),
                                      backgroundColor: Colors.red),
                                );
                              }
                            }),
                      )
                    : Expanded(
                        child: Text("Accept terms and conditions to sign up",
                            style: TextStyle(color: Colors.red)),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
