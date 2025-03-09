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

  Future<User?> signUp(
      {required String email,
      required String password,
      required role,
      required String fullName}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user role in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'role': role, // 'user', 'moderator', or 'admin'
        'workZoneId': 'workZone1',
        'status': 'checked-out',
      });

      print('User signed up: ${userCredential.user!.uid}');
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
    }
  }

  Future<void> saveUserDetails({
    required String company,
    required String department,
    required String title,
    required String? imageUrl,
  }) async {
    final user = auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'company': company,
        'department': department,
        'title': title,
        'imageUrl': imageUrl ?? '',
        'email': user.email,
      }, SetOptions(merge: true));
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
