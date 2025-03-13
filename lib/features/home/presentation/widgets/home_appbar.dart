import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HomeAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.teal[900]), // Menu Icon Color
      backgroundColor: Colors.white,
      shadowColor: Colors.grey[100],
      elevation: 3,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu), // Hamburger Menu
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Text(
              'Settings',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dark_mode, color: Colors.teal),
            title: Text('Dark'),
            onTap: () {
              // TODO: Implement Dark Mode Toggle
            },
          ),
          ListTile(
            leading: Icon(Icons.language, color: Colors.teal),
            title: Text('English'),
            onTap: () {
              // TODO: Implement Language Change
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.teal),
            title: Text('Logout'),
            onTap: () {
              // TODO: Implement Logout
            },
          ),
        ],
      ),
    );
  }
}
