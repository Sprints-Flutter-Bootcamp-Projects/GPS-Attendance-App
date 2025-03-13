part of 'attendancestatus_cubit.dart';

abstract class AttendanceStatusState extends Equatable {
  const AttendanceStatusState();

  @override
  List<Object> get props => [];
}

class AttendanceStatusInitial extends AttendanceStatusState {}

class AttendanceStatusLoading extends AttendanceStatusState {}

class AttendanceStatusLoaded extends AttendanceStatusState {
  final AttendanceRecord attendanceRecord;

  const AttendanceStatusLoaded({required this.attendanceRecord});
}

class AttendanceStatusUserIsAbsent extends AttendanceStatusState {}

class AttendanceStatusError extends AttendanceStatusState {
  final String errorMessage;

  const AttendanceStatusError({required this.errorMessage});
}
