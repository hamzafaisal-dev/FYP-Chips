import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Settings'),
        centerTitle: true,
      ),

      // body
      body: Column(
        children: [
          // profile & preferences settings
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile & Preferences'),
            onTap: () {
              Navigator.pushNamed(context, '/pnpSettings');
            },
          ),

          // alert settings
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text('Alerts'),
            onTap: () {
              Navigator.pushNamed(context, '/alertSettings');
            },
          ),

          // FOIs settings
          ListTile(
            leading: const Icon(Icons.cases_outlined),
            title: const Text('Fields of Interest'),
            onTap: () {
              Navigator.pushNamed(context, '/foiSettings');
            },
          ),

          // theme
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('Theme'),
            onTap: () {
              Navigator.pushNamed(context, '/themeSettings');
            },
          ),

          // about us
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About us'),
            onTap: () {
              Navigator.pushNamed(context, '/aboutUs');
            },
          ),
        ],
      ),
    );
  }
}
