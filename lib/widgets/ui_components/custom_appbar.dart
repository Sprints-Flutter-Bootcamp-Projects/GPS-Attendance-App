import 'package:flutter/material.dart';
import 'package:gps_attendance/core/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final String? button;
  final Widget? page;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.button,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.teal[900]),
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[100],
      elevation: 3,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      actions: button != null
          ? [
              TextButton(
                onPressed: () {
                  if (page != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => page!),
                    );
                  }
                },
                child: Text(
                  button!,
                  style: TextStyle(color: TrackSyncColors.highlightDarkest),
                ),
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
