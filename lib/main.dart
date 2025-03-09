import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/app.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/services/auth_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => AuthBloc(AuthService()),
    ),
  ], child: const MyApp()));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GPS Attendance System',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         useMaterial3: true,
//         brightness: Brightness.dark,
//       ),
//       initialRoute:
//           // '/login',
//           '/splash',
//       routes: {
//         '/splash': (context) => SplashScreen(),
//         // '/login': (context) => LoginScreen(),
//         // '/signup': (context) => SignUpScreen(),
//         // '/user': (context) => const UserPanel(),
//         // '/moderator': (context) => const ModeratorPanel(),
//         // '/admin': (context) => const AdminPanel(),
//       },
//     );
//   }
// }
