// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/signup_screen.dart';
import 'package:gps_attendance/landing_page.dart';
import 'package:gps_attendance/widgets/ui_components/nice_button.dart';
import 'package:gps_attendance/widgets/ui_components/text_form_field.dart';
import 'package:gps_attendance/widgets/ui_components/warnings/snackbar.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Image.asset(
                      'assets/images/logo.png',
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
                // password field
                CustomTextField(
                  label: 'Password',
                  labelIcon: Icons.lock,
                  controller: _passwordController,
                  obsecureText: true,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
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
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      TrackSyncSnackbar.show(
                          context, state.errorMessage, SnackbarType.error);
                    }

                    if (state is AuthSuccess) {
                      TrackSyncSnackbar.show(context, 'Logged In Successfully',
                          SnackbarType.success);

                      Navigator.pushReplacementNamed(
                          context, LandingPage.routeName);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return niceButton(
                          title: 'Login',
                          onTap: () {
                            if (_formkey.currentState?.validate() ?? false) {
                              context.read<AuthBloc>().add(LoginRequested(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim()));
                            } else {
                              SnackBar snackBar = SnackBar(
                                //snackbar showing if the data is valid or not
                                content: Text("invalid email or password"),
                                duration: Duration(seconds: 2),
                                action:
                                    SnackBarAction(label: "", onPressed: () {}),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                    }
                  },
                ),
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
                                builder: (context) => SignUpScreen()),
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
      ),
    );
  }

  togglePassword() {
    //hidding password function
    hiddenPassword = !hiddenPassword;
    setState(() {});
  }
}
