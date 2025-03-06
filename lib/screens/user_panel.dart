import 'package:flutter/material.dart';
import 'package:gps_attendance/services/auth_service.dart';
import '../widgets/attendance_history.dart';
import '../widgets/geofence_map.dart';
import '../services/location_service.dart';

class UserPanel extends StatelessWidget {
  const UserPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    final authService = AuthService();
    final user = authService.auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Panel'),
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
      body: Column(
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () async {
              print('Check-in');
              bool isWithinGeofence =
                  await locationService.isUserWithinGeofence();
              print(isWithinGeofence);
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
                    const SnackBar(content: Text('Checked out successfully!')),
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
    );
  }
}
