import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:gps_attendance/core/cubits/attendance_status/attendancestatus_cubit.dart';
import 'package:gps_attendance/features/history/presentation/cubits/today_stats_cubit.dart';
import 'package:gps_attendance/features/profile/presentation/cubits/user_profile/user_profile_cubit.dart';
import 'package:gps_attendance/core/themes/dark_theme.dart';
import 'package:gps_attendance/core/themes/light_theme.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';
import 'package:gps_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:gps_attendance/features/authentication/data/repositories/auth_repo.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/services/firestore_service.dart';
import 'package:gps_attendance/services/location_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase Instances
  final prefs = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  //Firebase services
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);
  //App services
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<LocationService>(() => LocationService());
  sl.registerLazySingleton<FirestoreService>(() => FirestoreService());

  // Register themes
  final lightThemeData = lightTheme();
  final darkThemeData = darkTheme();

  // Blocs
  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(lightTheme: lightThemeData, darkTheme: darkThemeData),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
        authService: sl<AuthService>(), prefs: sl<SharedPreferences>()),
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
  sl.registerFactory<UserProfileCubit>(
    () => UserProfileCubit(
        firebaseAuth: sl<FirebaseAuth>(),
        firestoreFirestore: sl<FirebaseFirestore>(),
        firestoreService: sl<FirestoreService>()),
  );
  sl.registerFactory<TodayStatsCubit>(
    () => TodayStatsCubit(firestoreService: sl<FirestoreService>()),
  );
}
