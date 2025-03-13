import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/models/user_model.dart';
import 'package:gps_attendance/core/models/work_zone.dart';
import 'package:gps_attendance/services/firestore_service.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  FirebaseFirestore firestoreFirestore;
  FirebaseAuth firebaseAuth;
  FirestoreService firestoreService;

  UserProfileCubit(
      {required this.firestoreFirestore,
      required this.firebaseAuth,
      required this.firestoreService})
      : super(UserProfileInitial()) {
    fetchUserData();
  }

  fetchUserData() async {
    emit(UserProfileLoading());
    if (firebaseAuth.currentUser != null) {
      final userId = firebaseAuth.currentUser!.uid;
      try {
        final doc =
            await firestoreFirestore.collection('users').doc(userId).get();
        UserModel user = UserModel.fromFirestore(doc);

        final String? workZone =
            await firestoreService.getUserWorkZoneName(userId);

        emit(UserProfileLoaded(user: user, workZone: workZone!));
      } catch (e) {
        emit(UserProfileError(errorMessage: e.toString()));
      }
    } else {
      emit(UserProfileUserNotAuthenticated());
    }
  }
}
