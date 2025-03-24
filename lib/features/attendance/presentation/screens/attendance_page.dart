import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:gps_attendance/features/attendance/presentation/widgets/area_status_chip.dart';
import 'package:gps_attendance/widgets/ui_components/buttons/button.dart';
import 'package:gps_attendance/widgets/ui_components/warnings/snackbar.dart';

class AttendancePage extends StatefulWidget {
  static const String routeName = '/attendance_page';
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _isMapMoving = false;
  GoogleMapController? _mapController;

  LatLng _userLocation = LatLng(0, 0);

  void _handleMapMoveStarted() {
    setState(() {
      _isMapMoving = true;
    });
  }

  void _handleMapMoveEnded() {
    setState(() {
      _isMapMoving = false;
    });
  }

  Future<void> _moveCameraToUserLocation(LatLng userLatLng) async {
    if (_mapController == null) return;

    try {
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: userLatLng,
          zoom: 11,
        )),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Camera move error: $e");
      }
    }
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AttendanceBloc>()..add(InitializeWorkZone()),
      child: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) async {
          if (state is AttendanceError) {
            TrackSyncSnackbar.show(
                context, state.errorMessage, SnackbarType.error);
          }

          if (state is AttendanceEmployeeAlreadyCheckedIn) {
            TrackSyncSnackbar.show(
              context,
              'You have already Checked in Today',
              SnackbarType.error,
            );
          }

          if (state is AttendanceEmployeeAlreadyCheckedOut) {
            TrackSyncSnackbar.show(
              context,
              'You have already Checked Out Today',
              SnackbarType.error,
            );
          }

          if (state is AttendanceFailedToGetWorkZone) {
            TrackSyncSnackbar.show(
              context,
              'Failed to Get Work Zone',
              SnackbarType.error,
            );
          }

          if (state is AttendanceEmployeeIsInArea) {
            setState(() {
              _userLocation = state.employeeLocation;
            });
            await _moveCameraToUserLocation(state.employeeLocation);
            if (context.mounted) {
              state.hasCheckedIn
                  ? TrackSyncSnackbar.show(
                      context,
                      'You Have Checked In Successfully!',
                      SnackbarType.success,
                    )
                  : TrackSyncSnackbar.show(
                      context,
                      'You Have Checked Out Successfully!',
                      SnackbarType.success,
                    );
            }
          }

          if (state is AttendanceEmployeeIsNotInArea) {
            setState(() {
              _userLocation = state.employeeLocation;
            });
            await _moveCameraToUserLocation(state.employeeLocation);
            if (context.mounted) {
              TrackSyncSnackbar.show(
                context,
                'You Can\'t Check in or out Outside Work Zone!',
                SnackbarType.warning,
              );
            }
          }
        },
        builder: (context, state) {
          final String workZoneName =
              context.read<AttendanceBloc>().workZone?.name ?? '';
          final double workZoneLat =
              context.read<AttendanceBloc>().workZone?.latitude ?? 0;
          final double workZoneLng =
              context.read<AttendanceBloc>().workZone?.longitude ?? 0;

          if (state is AttendanceWorkZoneLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Scaffold(
              appBar: AppBar(title: Text(workZoneName)),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(workZoneLat, workZoneLng),
                    zoom: 13,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('workZone-location'),
                      position: LatLng(workZoneLat, workZoneLng),
                    ),
                    Marker(
                      markerId: MarkerId('user-location'),
                      position: _userLocation,
                    ),
                  },
                  onCameraMoveStarted: () {
                    _handleMapMoveStarted();
                  },
                  onCameraIdle: () {
                    _handleMapMoveEnded();
                  },
                ),
              ),
              bottomSheet: _isMapMoving
                  ? SizedBox.shrink()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                workZoneName,
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: state is AttendanceEmployeeIsInArea
                                    ? AreaStatusChip(
                                        userWithinAreaStatus:
                                            UserWithinAreaStatus.withinArea,
                                      )
                                    : state is AttendanceEmployeeIsNotInArea
                                        ? AreaStatusChip(
                                            userWithinAreaStatus:
                                                UserWithinAreaStatus
                                                    .outsideArea,
                                          )
                                        : AreaStatusChip(
                                            userWithinAreaStatus:
                                                UserWithinAreaStatus.pending,
                                          ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: Text(
                                  'CURRENT SHIFT TIME\n 9:00 AM - 5:00 PM',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                    child: state is AttendanceCheckInLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : TrackSyncButton(
                                            text: 'Check In',
                                            onPressed: () {
                                              context
                                                  .read<AttendanceBloc>()
                                                  .add(CheckIn());
                                            },
                                          ),
                                  ),
                                  Expanded(
                                    child: state is AttendanceCheckOutLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : TrackSyncButton(
                                            text: 'Check Out',
                                            backgroundColor:
                                                TrackSyncColors.pending,
                                            onPressed: () {
                                              context
                                                  .read<AttendanceBloc>()
                                                  .add(CheckOut());
                                            },
                                          ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          }
        },
      ),
    );
  }
}
