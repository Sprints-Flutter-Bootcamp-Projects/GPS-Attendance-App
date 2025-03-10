import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sign up a new user and save their details in Firestore
  Future<User?> signUp({
    required String email,
    required String password,
    required String fullName,
    String? role = "user", // Default role
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        final userDetails = {
          "fullName": fullName,
          "email": email,
          "role": role,
          "createdAt": Timestamp.now(),
        };
        await _firestore.collection("users").doc(user.uid).set(userDetails);
      }
      return user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  /// Save or update user profile details
  Future<void> saveUserDetails({
    required String company,
    required String department,
    required String title,
    required String? imageUrl,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      final userDetails = {
        "company": company,
        "department": department,
        "title": title,
        "imageUrl": imageUrl ?? "",
        "email": user.email,
        "updatedAt": Timestamp.now(),
      };

      await _firestore.collection("users").doc(user.uid).set(userDetails, SetOptions(merge: true));
    }
  }

  /// Fetch user role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection("users").doc(uid).get();
      return doc.data()?["role"] as String?;
    } catch (e) {
      print("Error fetching role: $e");
      return null;
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
