import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:gps_attendance/core/app.dart';
import 'package:gps_attendance/features/authentication/screens/login_screen.dart';
// import 'package:gps_attendance/screens/login_screen.dart';
// import 'package:gps_attendance/screens/splash.dart';

import 'features/onboarding/screens/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS Attendance System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      initialRoute: 
      // '/login', 
      '/splash',
      routes: {
        '/splash':(context) => SplashScreen(),
        // '/login': (context) => LoginScreen(),
        // '/signup': (context) => SignUpScreen(),
        // '/user': (context) => const UserPanel(),
        // '/moderator': (context) => const ModeratorPanel(),
        // '/admin': (context) => const AdminPanel(),
      },
    );
  }
}
