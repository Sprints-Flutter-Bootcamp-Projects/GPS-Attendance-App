import 'package:flutter/material.dart';
import 'package:gps_attendance/services/auth_service.dart';
import 'package:gps_attendance/services/location_service.dart';
import 'package:gps_attendance/widgets/attendance_history.dart';
import 'package:gps_attendance/widgets/geofence_map.dart';

class ModeratorPanel extends StatelessWidget {
  const ModeratorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    final authService = AuthService();
    final user = authService.auth.currentUser;

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Moderator Panel'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Records'),
              Tab(text: 'All Records'),
            ],
          ),
        ),
        drawer: NavigationDrawer(children: [
          InkWell(
            onTap: () {
              authService.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: ListTile(
              leading: Text('Log Out'),
              trailing: Icon(Icons.logout),
            ),
          )
        ]),
        body: TabBarView(
          children: [
            // Tab 1: My Records
            Column(
              children: [
                Expanded(
                  flex: 2,
                  child: GeofenceMap(),
                ),
                Expanded(
                  flex: 3,
                  child: AttendanceHistory(userId: user?.uid),
                ),
              ],
            ),

            // Tab 2: All Records
            AttendanceHistory(showAllRecords: true),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () async {
                bool isWithinGeofence =
                    await locationService.isUserWithinGeofence();
                if (isWithinGeofence) {
                  await locationService.manualCheckIn();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Checked in successfully!')),
                    );
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'You must be inside the geofence to check in.')),
                    );
                  }
                }
              },
              tooltip: 'Check In',
              child: const Icon(Icons.login),
            ),
            FloatingActionButton(
              onPressed: () async {
                bool isWithinGeofence =
                    await locationService.isUserWithinGeofence();
                if (!isWithinGeofence) {
                  await locationService.manualCheckOut();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Checked out successfully!')),
                    );
                  }
                } else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'You must be outside the geofence to check out.')),
                    );
                  }
                }
              },
              tooltip: 'Check Out',
              child: const Icon(Icons.logout),
            ),
          ],
        ),
      ),
    );
  }
}
