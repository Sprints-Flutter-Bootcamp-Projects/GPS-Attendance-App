import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_attendance/core/models/user/user_model.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Get user data from Firestore
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw 'User document not found';
      }

      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      rethrow;
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
        'department': 'R&D',
        'role': 'user',
        'workZoneId': 'workZone1',
        'title': 'Flutter Developer'
      });
      if (userCredential.user != null) {
        return UserModel(
          email: email,
          fullName: fullName,
          department: 'R&D',
          id: userCredential.user!.uid,
          role: 'user',
          workZoneId: 'workZone1',
          title: 'Flutter Developer',
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
