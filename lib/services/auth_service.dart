import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> signUp(String email, String password, String role) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user role in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role, // 'user', 'moderator', or 'admin'
        'workZoneId': 'workZone1',
        'status': 'checked-out',
      });

      print('User signed up: ${userCredential.user!.uid}');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
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
