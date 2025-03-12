import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';
import 'package:gps_attendance/features/attendance/presentation/attendance_page.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/login_screen.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/signup_screen.dart';
import 'package:gps_attendance/features/history/presentation/pages/history_page.dart';
import 'package:gps_attendance/landing_page.dart';

import 'package:gps_attendance/core/dependency_injection/service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => sl<ThemeBloc>()),
        BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        final themeBloc = BlocProvider.of<ThemeBloc>(context);
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: themeBloc.themeData,
          themeMode: ThemeMode.system,
          initialRoute: LoginScreen.routeName,
          routes: {
            LoginScreen.routeName: (context) => LoginScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            AttendancePage.routeName: (context) => AttendancePage(),
            LandingPage.routeName: (context) => LandingPage(),
            HistoryPage.routeName: (context) => HistoryPage(),
          },
        );
      }),
    );
  }
}
