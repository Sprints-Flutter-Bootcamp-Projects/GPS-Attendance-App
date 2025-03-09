import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:gps_attendance/core/themes/dark_theme.dart';
import 'package:gps_attendance/core/themes/light_theme.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';


final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase Instances
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);

  // Blocs



  // Register themes
  final lightThemeData = lightTheme();
  final darkThemeData = darkTheme();

  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(lightTheme: lightThemeData, darkTheme: darkThemeData),
  );
}
