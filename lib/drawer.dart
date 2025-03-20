import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/themes/theme_bloc/theme_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gps_attendance/features/authentication/presentation/screens/login_screen.dart';
import 'package:gps_attendance/features/settings/presentation/admin_settings.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            // Navigate when logout completes
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
              (route) => false,
            );
          }
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.role == null) return const SizedBox.shrink();

                  if (state.role!.isAdmin) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin\n${state.user!.fullName}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SettingsWidget();
                              },
                            );
                          },
                          trailing: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          title: Text(
                            'Admin Settings',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    );
                  } else if (state.role!.isModerator) {
                    return Text(
                      'Manager\n${state.user!.fullName}',
                      style: TextStyle(color: Colors.white),
                    );
                  } else if (state.role!.isUser) {
                    return Text(
                      'User\n${state.user!.fullName}',
                      style: TextStyle(color: Colors.white),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
            ListTile(
              leading:
                  Icon(Icons.dark_mode, color: Theme.of(context).primaryColor),
              title: Text(
                'Dark',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                BlocProvider.of<ThemeBloc>(context).add(ToggleThemeEvent());
              },
            ),
            Divider(color: Theme.of(context).primaryColor),
            ListTile(
              leading:
                  Icon(Icons.language, color: Theme.of(context).primaryColor),
              title: Text(
                'English',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                context.locale == Locale('en')
                    ? context.setLocale(Locale('ar'))
                    : context.setLocale(Locale('en'));
              },
            ),
            Divider(color: Theme.of(context).primaryColor),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AuthSuccess) {
                  return ListTile(
                    leading: Icon(Icons.logout,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      'Logout',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onTap: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                      Navigator.pop(context);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
