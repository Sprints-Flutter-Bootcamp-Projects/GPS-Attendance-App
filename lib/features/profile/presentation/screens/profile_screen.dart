import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/dependency_injection/service_locator.dart';
import 'package:gps_attendance/core/utils/app_colors.dart';
import 'package:gps_attendance/features/profile/presentation/cubits/user_profile/user_profile_cubit.dart';
import 'package:gps_attendance/features/profile/presentation/screens/edit_profile.dart';
import 'package:gps_attendance/widgets/custom_appbar.dart';
import 'package:gps_attendance/widgets/warnings/snackbar.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile_screen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _userData;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadCachedUserData();
  // }

  // Future<void> _loadCachedUserData() async {
  //   final cachedData = await SharedPreferencesService().getCachedUserData();
  //   setState(() {
  //     _userData = cachedData;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: 'Profile', page: EditProfileScreen(), button: 'Edit'),
      body: BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileError) {
            TrackSyncSnackbar.show(
                context, state.errorMessage, SnackbarType.error);
          }
        },
        builder: (context, state) {
          if (state is UserProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserProfileLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  AssetImage('assets/images/Avatar.png')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              sl<FirebaseAuth>().currentUser!.displayName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(
                              'Employee',
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: profileCard(state))
              ],
            );
          } else if (state is UserProfileUserNotAuthenticated) {
            return Center(child: Text('User is not Authenticated'));
          } else {
            return Center(child: Text('Failed to fetch user Data'));
          }
        },
      ),
    );
  }

  Widget profileCard(UserProfileLoaded state) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
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
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.user.email),
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
                  child: Text(
                    'Work Office',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.workZone),
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
                  child: Text(
                    'Department',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(state.user.department),
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
                  child: Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
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
