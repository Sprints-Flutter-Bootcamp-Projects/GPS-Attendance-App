import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/models/user_model.dart';
import 'package:gps_attendance/services/firestore_service.dart';

part 'attendancestatus_state.dart';

class AttendanceStatusCubit extends Cubit<AttendanceStatusState> {
  FirestoreService firestoreService;
  AttendanceStatusCubit({required this.firestoreService})
      : super(AttendanceStatusInitial()) {
    getAttendanceRecord();
  }

  void getAttendanceRecord() async {
    emit(AttendanceStatusLoading());
    try {
      final record = await firestoreService
          .getCurrentUserAttendanceRecordForDay(DateTime.now());

      if (record == null) {
        emit(AttendanceStatusUserIsAbsent());
      } else {
        emit(AttendanceStatusLoaded(attendanceRecord: record));
      }
    } catch (e) {
      emit(AttendanceStatusError(errorMessage: e.toString()));
    }
  }
}
