import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue.shade300),
            child: const Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Audio'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/audio');
            },
          ),
          ListTile(
            title: const Text('RegExr'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/regexr');
            },
          ),
        ],
      ),
    );
  }
}
