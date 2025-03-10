import 'package:flutter/material.dart';
import 'package:gps_attendance/features/home/presentation/widgets/card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/color_outline_btn.dart';
import 'package:gps_attendance/features/home/presentation/widgets/quick_states.dart';
import 'package:gps_attendance/features/home/presentation/widgets/shift_card.dart';
import 'package:gps_attendance/features/home/presentation/widgets/state_row.dart';
import 'package:gps_attendance/widgets/appbar.dart';
import 'package:gps_attendance/widgets/title_desc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(title: "Home"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TitleDesc(title: "Quick Stats"),
              QuickStats(),
              const TitleDesc(title: "Summary"),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                  border: Border.all(
                    color: const Color(0xFF0097A7), // Border color
                    width: 1.5, // Border thickness
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.teal,
                        radius: 20, // Adjusted size for better visibility
                      ),
                      title: const Text("Mohamed"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Attendance Status
                          RichText(
                            text: const TextSpan(
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Attendance Status • ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: "Checked In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Last Check-in
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Last check-in • 9:12 AM",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Location
                          Row(
                            children: const [
                              Icon(Icons.location_on,
                                  color: Colors.blue, size: 18),
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
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
              const DepartmentCard(),
              const SizedBox(height: 10),
              const ShiftDetailsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
