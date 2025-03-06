import 'package:flutter/material.dart';
import '../widgets/attendance_history.dart';
import '../widgets/geofence_map.dart';
import '../services/location_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locationService = LocationService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: GeofenceMap(),
          ),
          Expanded(
            flex: 3,
            child: AttendanceHistory(),
          ),
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
                    SnackBar(content: Text('Checked in successfully!')),
                  );
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'You must be inside the geofence to check in.')),
                  );
                }
              }
            },
            tooltip: 'Check In',
            child: Icon(Icons.login),
          ),
          FloatingActionButton(
            onPressed: () async {
              bool isWithinGeofence =
                  await locationService.isUserWithinGeofence();
              if (!isWithinGeofence) {
                await locationService.manualCheckOut();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Checked out successfully!')),
                  );
                }
              } else {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'You must be outside the geofence to check out.')),
                  );
                }
              }
            },
            tooltip: 'Check Out',
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
