part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceWorkZoneLoading extends AttendanceState {}

class AttendanceWorkZoneLoaded extends AttendanceState {}

class AttendanceCheckInLoading extends AttendanceState {}

class AttendanceCheckOutLoading extends AttendanceState {}

class AttendanceEmployeeIsInArea extends AttendanceState {
  final LatLng employeeLocation;
  final bool hasCheckedIn;

  const AttendanceEmployeeIsInArea(
      {required this.employeeLocation, required this.hasCheckedIn});
}

class AttendanceEmployeeIsNotInArea extends AttendanceState {
  final LatLng employeeLocation;

  const AttendanceEmployeeIsNotInArea({required this.employeeLocation});
}

class AttendanceEmployeeAlreadyCheckedIn extends AttendanceState {}

class AttendanceEmployeeAlreadyCheckedOut extends AttendanceState {}

class AttendanceFailedToGetWorkZone extends AttendanceState {}

class AttendanceError extends AttendanceState {
  final String errorMessage;

  const AttendanceError({required this.errorMessage});
}
