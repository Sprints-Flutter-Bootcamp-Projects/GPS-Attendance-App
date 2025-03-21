part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object> get props => [];
}

class CheckIn extends AttendanceEvent {}

class CheckOut extends AttendanceEvent {}

class InitializeWorkZone extends AttendanceEvent {}
