import 'package:flutter/material.dart';
import 'package:gps_attendance/models/geofence_settings.dart';
import 'package:gps_attendance/models/work_zone.dart';
import 'package:gps_attendance/services/auth_service.dart';
import 'package:gps_attendance/services/firestore_service.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    final firestoreService = FirestoreService();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Manage Roles',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () async {
              // Fetch all users and allow the admin to assign roles
              final users = await firestoreService.getAllUsers();
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Assign Roles'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return ListTile(
                              title: Text(user['email']),
                              subtitle: Text('Current Role: ${user['role']}'),
                              trailing: DropdownButton<String>(
                                value: user['role'],
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    authService.assignRole(
                                        user['uid'], newValue);
                                  }
                                },
                                items: <String>[
                                  'user',
                                  'moderator',
                                  'admin'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Assign Roles'),
          ),
          const SizedBox(height: 20),
          const Text('Geofence Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () async {
              // Allow the admin to update geofence settings
              final settings = await firestoreService.getGeofenceSettings();
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) {
                    final radiusController =
                        TextEditingController(text: settings.radius.toString());
                    final distanceFilterController = TextEditingController(
                        text: settings.distanceFilter.toString());
                    String accuracy = settings.accuracy.toString();

                    return AlertDialog(
                      title: const Text('Update Geofence Settings'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: radiusController,
                            decoration: const InputDecoration(
                                labelText: 'Geofence Radius (degrees)'),
                          ),
                          TextField(
                            controller: distanceFilterController,
                            decoration: const InputDecoration(
                                labelText: 'Distance Filter (meters)'),
                          ),
                          DropdownButton<String>(
                            value: accuracy,
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                accuracy = newValue;
                              }
                            },
                            items: <String>[
                              'LocationAccuracy.low',
                              'LocationAccuracy.medium',
                              'LocationAccuracy.high',
                              'LocationAccuracy.best',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final newSettings = GeofenceSettings(
                              radius: double.parse(radiusController.text),
                              distanceFilter:
                                  int.parse(distanceFilterController.text),
                              accuracy:
                                  GeofenceSettings.parseAccuracy(accuracy),
                            );
                            await firestoreService
                                .updateGeofenceSettings(newSettings);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Update Geofence Settings'),
          ),
          const SizedBox(height: 20),
          const Text('Manage Work Zones',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(
            onPressed: () async {
              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (context) {
                    final nameController = TextEditingController();
                    final latController = TextEditingController();
                    final lngController = TextEditingController();

                    return AlertDialog(
                      title: const Text('Add Work Zone'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                labelText: 'Work Zone Name'),
                          ),
                          TextField(
                            controller: latController,
                            decoration:
                                const InputDecoration(labelText: 'Latitude'),
                          ),
                          TextField(
                            controller: lngController,
                            decoration:
                                const InputDecoration(labelText: 'Longitude'),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final workZone = WorkZone(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              name: nameController.text,
                              latitude: double.parse(latController.text),
                              longitude: double.parse(lngController.text),
                            );
                            await firestoreService.addWorkZone(workZone);
                            if (context.mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: const Text('Add Work Zone'),
          ),
        ],
      ),
    );
  }
}
