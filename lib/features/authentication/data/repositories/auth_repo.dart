import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp(
      {required String email,
      required String password,
      required String fullName}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _saveUserToFirestore(user.uid, fullName, email);
      }
      return user;
    } catch (e) {
      print("Error signing up: $e");
      return null;
    }
  }

  Future<void> _saveUserToFirestore(
      String uid, String fullName, String email) async {
    await _firestore.collection("users").doc(uid).set({
      "fullName": fullName,
      "email": email,
      "createdAt": Timestamp.now(),
    });
  }
}
