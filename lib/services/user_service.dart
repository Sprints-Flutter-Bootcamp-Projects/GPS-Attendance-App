import 'package:firebase_auth/firebase_auth.dart';
import 'package:gps_attendance/services/shared_preference.dart';
import 'auth_service.dart';

Future<void> signUpAndCacheUser({
  required String email,
  required String password,
  required String fullName,
}) async {
  // Step 1: Sign up the user using AuthService
  User? user = await AuthService().signUp(
    email: email,
    password: password,
    fullName: fullName,
  );

  if (user != null) {
    // Step 2: Fetch user details to cache
    final userDetails = {
      "fullName": fullName,
      "email": email,
      "role": "user", // Default role
      "createdAt": DateTime.now().toIso8601String(), // Optional timestamp
    };

    // Step 3: Save user data in Shared Preferences
    await SharedPreferencesService().cacheUserData(userDetails);

    print("User data cached successfully!");
  } else {
    print("Sign-up failed. User not created.");
  }
}
