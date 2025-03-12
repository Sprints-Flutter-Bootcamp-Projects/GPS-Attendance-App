import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/features/attendance/presentation/attendance_page.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/profile_screen.dart';
import 'package:gps_attendance/features/history/presentation/pages/history_page.dart';
import 'package:gps_attendance/features/home/presentation/home_page.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landingpage';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = <Widget>[
    HomePage(),
    AttendancePage(),
    HistoryPage(),
    ProfileScreen()
  ];

  int selectedPage = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: pages[selectedPage],
      bottomNavigationBar: NavigationBar(
        backgroundColor: TrackSyncColors.highlightLight,
        selectedIndex: selectedPage,
        onDestinationSelected: _onItemTapped,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: context.tr('home_page'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.check_box_outlined),
            selectedIcon: const Icon(Icons.check_box),
            label: context.tr('attendance_page'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: context.tr('history_page'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: context.tr('profile'),
          ),
        ],
      ),
    );
  }
}
