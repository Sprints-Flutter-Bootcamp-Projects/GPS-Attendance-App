import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:gps_attendance/core/cubits/attendance_status/attendancestatus_cubit.dart';
import 'package:gps_attendance/core/themes/dark_theme.dart';
import 'package:gps_attendance/core/themes/light_theme.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';
import 'package:gps_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:gps_attendance/features/authentication/data/repositories/auth_repo.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/services/firestore_service.dart';
import 'package:gps_attendance/services/location_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase Instances
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  sl.registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<LocationService>(() => LocationService());
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService());
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
  sl.registerFactory<AttendanceBloc>(
    () => AttendanceBloc(locationService: sl<LocationService>()),
  );
  sl.registerFactory<MonthStatsCubit>(
    () => MonthStatsCubit(firestoreService: sl<FirestoreService>()),
  );
  sl.registerFactory<AttendanceStatusCubit>(
    () => AttendanceStatusCubit(firestoreService: sl<FirestoreService>()),
  );
}
