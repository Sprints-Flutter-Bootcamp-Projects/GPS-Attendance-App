import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/core/cubits/monthstats/monthstats_cubit.dart';
import 'package:gps_attendance/features/home/presentation/widgets/attendance_status.dart';
import 'package:gps_attendance/features/home/presentation/widgets/department_card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/check_in_out_line.dart';
import 'package:gps_attendance/features/home/presentation/widgets/color_outline_btn.dart';
import 'package:gps_attendance/features/home/presentation/widgets/colored_card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/date_text.dart';
import 'package:gps_attendance/features/home/presentation/widgets/home_appbar.dart';
import 'package:gps_attendance/features/home/presentation/widgets/quick_states.dart';
import 'package:gps_attendance/features/home/presentation/widgets/shift_card.dart';
import 'package:gps_attendance/widgets/title_desc.dart';

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 25,
                      ),
                      title: const Text("Mohamed"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DateText(date: DateTime.now()),
                          AttendanceStatus(status: "Checked In"),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Check-in and check-out
                    CheckInOutWidget(label: "Last check-in", time: "9:12 AM"),
                    const SizedBox(height: 8),

                    // Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 16),
                        Icon(Icons.location_on, color: Colors.blue, size: 18),
                        SizedBox(width: 4),
                        Text(
                          "Main Office - Building A",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
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
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const TitleDesc(title: "Department & Shift Info"),
              const DepartmentCard(
                departmentName: "IT",
                leadPosition: "Lead",
                leadName: "Mohamed",
                contactInfo: "0123456789",
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
