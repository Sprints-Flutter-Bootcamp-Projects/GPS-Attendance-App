import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/models/user/user_model.dart';
import 'package:gps_attendance/services/firestore_service.dart';
import 'package:intl/intl.dart';

part 'attendancestatus_state.dart';

class AttendanceStatusCubit extends Cubit<AttendanceStatusState> {
  FirestoreService firestoreService;
  AttendanceStatusCubit({required this.firestoreService})
      : super(AttendanceStatusInitial()) {
    getAttendanceRecord();
  }

  Future<void> getAttendanceRecord() async {
    emit(AttendanceStatusLoading());
    try {
      final record = await firestoreService
          .getCurrentUserAttendanceRecordForDay(DateTime.now());

      if (record == null) {
        emit(AttendanceStatusUserIsAbsent());
      } else {
        if (record.status == 'Checked In') {
          emit(
            AttendanceStatusUserCheckedIn(
              checkInTime: _timeFormat(record.checkIn),
            ),
          );
        } else if (record.status == 'Checked Out') {
          emit(
            AttendanceStatusUserCheckedOut(
              checkInTime: _timeFormat(record.checkIn),
              checkOutTime: _timeFormat(record.checkOut!),
            ),
          );
        }
      }
    } catch (e) {
      emit(AttendanceStatusError(errorMessage: e.toString()));
    }
  }

  String _timeFormat(DateTime time) {
    return DateFormat.jm().format(time);
  }
}
