// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/authentication/screens/account_type.dart';

import 'package:gps_attendance/features/authentication/screens/signup_screen.dart';
import 'package:gps_attendance/widgets/nice_button.dart';
import 'package:gps_attendance/widgets/text_form_field.dart';

import '../../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool hiddenPassword = true;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                top: 10,
                child: Center(
                  child: Image.asset(
                    'assets/images/image.png',
                    width: 248,
                    height: 248,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // email field
              CustomTextField(
                label: 'Email',
                labelIcon: Icons.email,
                controller: _emailController,
                validator: (value) {
                  //checking the validation of an email
                  if (value != null && value.isEmpty) {
                    return "email can't be empty";
                  } else if (value != null && !value.contains('@')) {
                    //must contain @ character
                    print("email must have");
                    SnackBar snackBar = SnackBar(
                      content: Text("invalid syntax"),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  return null;
                },
              ),
              // password field
              CustomTextField(
                label: 'Password',
                labelIcon: Icons.lock,
                controller: _passwordController,
                obsecureText: true,
                isPassword: true,
                validator: (value) {
                  //checking the validation of the password
                  if (value != null && value.isEmpty) {
                    return "password is empty";
                  } else if (value != null && value.length < 6) {
                    SnackBar snackBar = SnackBar(
                      content: Text('Wrong password'),
                      duration: Duration(seconds: 2),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  return null;
                },
              ),

              TextButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateColor.transparent),
                  onPressed: () {},
                  child: Text(
                    'Forgot Password? Click here',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                  )),
              niceButton(
                  title: 'Login',
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    } else {
                      SnackBar snackBar = SnackBar(
                        //snackbar showing if the data is valid or not
                        content: Text("invalid email or password"),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(label: "", onPressed: () {}),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a Member?',
                      style: TextStyle(color: Color(0xFF71727A)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AccountsPage()),
                        );
                      },
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  togglePassword() {
    //hidding password function
    hiddenPassword = !hiddenPassword;
    setState(() {});
  }
}
