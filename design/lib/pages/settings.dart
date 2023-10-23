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
          // alert settings
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: const Text('Alerts'),
            onTap: () {
              Navigator.pushNamed(context, '/alertSettings');
            },
          ),

          // preferences settings
          ListTile(
            title: const Text('Preferences'),
            leading: const Icon(Icons.tune),
            onTap: () {
              Navigator.pushNamed(context, '/preferences');
            },
          ),

          // change password
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.pushNamed(context, '/changePassword');
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
