import 'package:flutter/material.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/edit_profile.dart';
import 'package:gps_attendance/widgets/appbar.dart';
import '../../../../services/shared_preference.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _loadCachedUserData();
  }

  Future<void> _loadCachedUserData() async {
    final cachedData = await SharedPreferencesService().getCachedUserData();
    setState(() {
      _userData = cachedData;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Profile',
      page: EditPage(),
      button: 'Edit'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              child: 
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage('assets/images/Avatar.png')
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)
                              ),
                              child: Text('Employee',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold
                              ),),
                            )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: profileCard()
          )
        ],
      ),
    );
  }
  Widget profileCard(){
    return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.primaryColor
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Email',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('employee@gmail.com'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Company',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Sprints'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Department',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('R&D'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Title',style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Software Developer'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
  }
}
