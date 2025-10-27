import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  final bool isDark;
  final Function(bool) onThemeChanged;

  const DrawerScreen({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });


  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Center(
              child: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          ListTile(
            leading: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
            title: Text(isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode'),
            onTap: () {
              onThemeChanged(!isDark);
            },
          ),
        ],
      ),
    );
  }
}
