import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  const HomeAppBar({
    Key? key,
    required this.title,
    this.onBack,
  }) : super(key: key);

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
      actions: [
        IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.teal[900],
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
