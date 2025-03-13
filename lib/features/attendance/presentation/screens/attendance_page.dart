import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/features/attendance/presentation/bloc/attendance_bloc.dart';
import 'package:gps_attendance/features/attendance/presentation/widgets/area_status_chip.dart';
import 'package:gps_attendance/widgets/buttons/button.dart';
import 'package:gps_attendance/widgets/warnings/snackbar.dart';

class AttendancePage extends StatefulWidget {
  static const String routeName = '/attendance_page';
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool _isMapMoving = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static final LatLng _cairoOfficeLocation = const LatLng(30.0444, 31.2357);

  LatLng _userLocation = LatLng(0, 0); // Default to Cairo

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
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: userLatLng,
      zoom: 11,
    )));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AttendanceBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Main Office - Building A')),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GoogleMap(
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _cairoOfficeLocation,
              zoom: 13,
            ),
            markers: {
              Marker(
                markerId: MarkerId('selected-location'),
                position: _cairoOfficeLocation,
              ),
              Marker(
                markerId: MarkerId('selected-location'),
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
            : BlocConsumer<AttendanceBloc, AttendanceState>(
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
                              'You Have Check In Successfully!',
                              SnackbarType.success,
                            )
                          : TrackSyncSnackbar.show(
                              context,
                              'You Have Check Out Successfully!',
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text('Main Office - Building A',
                              style: Theme.of(context).textTheme.displayMedium),
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
                                            UserWithinAreaStatus.outsideArea,
                                      )
                                    : AreaStatusChip(
                                        userWithinAreaStatus:
                                            UserWithinAreaStatus.pending,
                                      ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7),
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
                                    ? Center(child: CircularProgressIndicator())
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
                                    ? Center(child: CircularProgressIndicator())
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
                  );
                },
              ),
      ),
    );
  }
}
