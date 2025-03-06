import 'package:flutter/material.dart';
import 'package:gps_attendance/screens/location_settings.dart';
import 'package:gps_attendance/services/auth_service.dart';
import 'package:gps_attendance/services/firestore_service.dart';
import 'package:gps_attendance/widgets/attendance_history.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final firestoreService = FirestoreService();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Panel'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'All Records', icon: Icon(Icons.document_scanner)),
              Tab(text: 'Settings', icon: Icon(Icons.settings)),
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
            // Tab 1: All Records
            AttendanceHistory(showAllRecords: true),

            // Tab 2: Settings
            SettingsWidget(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Example: Delete a record
            final recordId = 'exampleRecordId';
            await firestoreService.deleteAttendanceRecord(recordId);
          },
          tooltip: 'Delete Record',
          child: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
