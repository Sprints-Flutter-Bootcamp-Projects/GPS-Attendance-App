import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/home/presentation/pages/home_screen.dart';
import 'package:gps_attendance/homepage.dart';
import 'package:gps_attendance/features/onboarding/presentation/screens/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: MyHomePage(
      //   title: 'Demo',
      // ),
      // home: SplashScreen(),
      home: HomeScreen(),
    );
  }
}
