import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance/services/location_service.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final LocationService locationService;

  AttendanceBloc({required this.locationService}) : super(AttendanceInitial()) {
    on<CheckIn>(_checkIn);
    on<CheckOut>(_checkOut);
  }
  _checkIn(AttendanceEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceCheckInLoading());
    try {
      final geofenceResult = await locationService.isUserWithinGeofence();

      if (geofenceResult == null) {
        emit(AttendanceFailedToGetWorkZone());
        return null;
      }

      if (geofenceResult.isWithinGeofence) {
        bool userhasCheckedIn = await locationService.checkIn();

        if (userhasCheckedIn) {
          emit(AttendanceEmployeeIsInArea(
              employeeLocation: geofenceResult.userLatLng, hasCheckedIn: true));
        } else {
          emit(AttendanceEmployeeAlreadyCheckedIn());
        }
      } else {
        emit(
          AttendanceEmployeeIsNotInArea(
              employeeLocation: geofenceResult.userLatLng),
        );
      }
    } catch (e) {
      emit(AttendanceError(errorMessage: e.toString()));
    }
  }

  _checkOut(AttendanceEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceCheckOutLoading());
    try {
      final geofenceResult = await locationService.isUserWithinGeofence();

      if (geofenceResult == null) {
        emit(AttendanceFailedToGetWorkZone());
        return null;
      }

      if (geofenceResult.isWithinGeofence) {
        bool userhasCheckedOut = await locationService.checkOut();

        if (userhasCheckedOut) {
          emit(AttendanceEmployeeIsInArea(
              employeeLocation: geofenceResult.userLatLng,
              hasCheckedIn: false));
        } else {
          emit(AttendanceEmployeeAlreadyCheckedOut());
        }
      } else {
        emit(
          AttendanceEmployeeIsNotInArea(
              employeeLocation: geofenceResult.userLatLng),
        );
      }
    } catch (e) {
      emit(AttendanceError(errorMessage: e.toString()));
    }
  }
}
