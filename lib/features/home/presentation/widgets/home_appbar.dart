import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const HomeAppBar({
    super.key,
    required this.title,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.teal[900]),
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[100],
      elevation: 3,
      centerTitle: true,
      // leading: IconButton(
      //   onPressed: onBack ?? () => Navigator.pop(context),
      //   icon: const Icon(Icons.arrow_back_ios),
      // ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
