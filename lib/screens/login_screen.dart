import 'package:flutter/material.dart';
import 'package:gps_attendance/screens/signup_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.signIn(
                  _emailController.text,
                  _passwordController.text,
                );
                if (context.mounted) {
                  final user = authService.auth.currentUser;
                  if (user != null) {
                    final role = await authService.getUserRole(user.uid);
                    if (role == 'admin') {
                      Navigator.pushReplacementNamed(context, '/admin');
                    } else if (role == 'moderator') {
                      Navigator.pushReplacementNamed(context, '/moderator');
                    } else {
                      Navigator.pushReplacementNamed(context, '/user');
                    }
                  }
                }
              },
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
