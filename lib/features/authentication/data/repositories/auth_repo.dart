import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_attendance/core/models/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('User signed in: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
    }
  }

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(fullName);

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'fullName': fullName,
        'department': 'Not Assigned',
        'role': 'user',
        'workZoneId': 'workZone1',
      });
      if (userCredential.user != null) {
        return UserModel(
          email: email,
          fullName: fullName,
          department: 'Not Assigned',
          id: userCredential.user!.uid,
          role: 'user',
          workZoneId: 'workZone1',
        );
      } else {
        return null;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> assignRole(String userId, String role) async {
    await _firestore.collection('users').doc(userId).update({
      'role': role,
    });
  }

  Future<String?> getUserRole(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc['role'] as String?;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
