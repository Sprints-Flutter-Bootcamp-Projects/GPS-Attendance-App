import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gps_attendance/app.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();

  final SharedPreferences prefs = sl<SharedPreferences>();

  final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) await prefs.setBool('isFirstLaunch', false);

  runApp(EasyLocalization(
    supportedLocales: [Locale('en'), Locale('ar')],
    path: 'assets/translations', // <-- change the path of the translation files
    fallbackLocale: Locale('en'),
    child: MyApp(isFirstLaunch: isFirstLaunch),
  ));
}
