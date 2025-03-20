import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/models/user/user_role.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/features/history/presentation/pages/tabs/personal.dart';
import 'package:gps_attendance/features/history/presentation/pages/tabs/company.dart';

class HistoryPage extends StatelessWidget {
  static const String routeName = '/history';
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthBloc, AuthState, UserRole?>(
      selector: (state) => state.role,
      builder: (context, role) {
        if (role == null) {
          return const Center(child: Text('User Is Not logged In'));
        }
        if (role.isAdmin || role.isModerator) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text('History'),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48.0),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: TabBar(
                        padding: EdgeInsets.all(5),
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w500),
                        tabs: const [
                          Tab(text: 'Personal'),
                          Tab(text: 'Company'),
                        ],
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  PersonalHistoryTab(),
                  AttendanceScreen(),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('History')),
            body: const PersonalHistoryTab(),
          );
        }
      },
    );
  }
}
