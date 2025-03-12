import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:gps_attendance/core/themes/dark_theme.dart';
import 'package:gps_attendance/core/themes/light_theme.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';
import 'package:gps_attendance/features/authentication/data/repositories/auth_repo.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/services/location_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase Instances
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<LocationService>(() => LocationService());
  // Blocs

  // Register themes
  final lightThemeData = lightTheme();
  final darkThemeData = darkTheme();

  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(lightTheme: lightThemeData, darkTheme: darkThemeData),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(sl<AuthService>()),
  );
}
