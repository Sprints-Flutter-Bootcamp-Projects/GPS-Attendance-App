import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/cubits/attendance_status/attendancestatus_cubit.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/drawer.dart';
import 'package:gps_attendance/features/home/presentation/widgets/attendance_status.dart';
import 'package:gps_attendance/features/home/presentation/widgets/department_card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/check_in_out_line.dart';
import 'package:gps_attendance/features/home/presentation/widgets/color_outline_btn.dart';
import 'package:gps_attendance/features/home/presentation/widgets/colored_card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/date_text.dart';
import 'package:gps_attendance/features/home/presentation/widgets/home_appbar.dart';
import 'package:gps_attendance/features/home/presentation/widgets/quick_states.dart';
import 'package:gps_attendance/features/home/presentation/widgets/shift_card.dart';
import 'package:gps_attendance/features/profile/presentation/cubits/user_profile/user_profile_cubit.dart';
import 'package:gps_attendance/widgets/common_widgets/attendance_history_list.dart';
import 'package:gps_attendance/widgets/ui_components/title_desc.dart';
import 'package:gps_attendance/widgets/ui_components/warnings/snackbar.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(title: "Home"),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Quick Stats
              const TitleDesc(title: "Quick Stats"),
              BlocProvider(
                create: (context) => sl<MonthStatsCubit>(),
                child: QuickStats(),
              ),

              // Summary Card
              const TitleDesc(title: "Summary"),
              ColoredCard(
                backgroundColor: Colors.white,
                borderColor: const Color(0xFF0097A7),
                child: BlocProvider(
                  create: (context) => sl<AttendanceStatusCubit>(),
                  child: BlocConsumer<AttendanceStatusCubit,
                      AttendanceStatusState>(
                    listener: (context, state) {
                      if (state is AttendanceStatusError) {
                        TrackSyncSnackbar.show(
                            context, state.errorMessage, SnackbarType.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is AttendanceStatusLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is AttendanceStatusError) {
                        return Text(
                            "Error loading attendance status: ${state.errorMessage}");
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Colors.teal,
                                radius: 25,
                                backgroundImage:
                                    AssetImage('assets/images/Avatar.png'),
                              ),
                              title: Text(
                                  sl<FirebaseAuth>().currentUser!.displayName!),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DateText(date: DateTime.now()),
                                  AttendanceStatus(
                                    status: state
                                            is AttendanceStatusUserCheckedIn
                                        ? 'Checked In'
                                        : state is AttendanceStatusUserCheckedOut
                                            ? 'Checked Out'
                                            : "Absent",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Check-in and check-out
                            state is AttendanceStatusUserCheckedIn
                                ? CheckInOutWidget(
                                    label: "Last Check-in",
                                    time: state.checkInTime)
                                : state is AttendanceStatusUserCheckedOut
                                    ? CheckInOutWidget(
                                        label: "Last Check-Out",
                                        time: state.checkOutTime)
                                    : SizedBox.shrink(),
                            const SizedBox(height: 8),

                            // Location
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 16),
                                Icon(Icons.location_on,
                                    color: Colors.blue, size: 18),
                                SizedBox(width: 4),
                                BlocBuilder<UserProfileCubit, UserProfileState>(
                                  builder: (context, state) {
                                    return Text(
                                      state is UserProfileLoaded
                                          ? state.workZone
                                          : 'Failed to load Workzone',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            // Check-in and check-out buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ColorOutBtn(
                                  color: const Color(0xFF0097A7),
                                  text: "Check Out",
                                  onTap: () {},
                                ),
                                ColorOutBtn(
                                  color: Colors.orange,
                                  text: "View Details",
                                  onTap: () {
                                    final FirebaseAuth auth =
                                        sl<FirebaseAuth>();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return UserAttendanceHistory(
                                            fullName:
                                                auth.currentUser!.displayName,
                                            userId: auth.currentUser!.uid,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const TitleDesc(title: "Department & Shift Info"),
              DepartmentCard(
                departmentName: "IT",
                leadPosition: "Lead",
                leadName: FirebaseAuth.instance.currentUser!.displayName!,
                contactInfo: FirebaseAuth.instance.currentUser!.email!,
              ),
              const SizedBox(height: 10),
              const ShiftDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
