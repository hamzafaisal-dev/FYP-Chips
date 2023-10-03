import 'package:design/responsiveness.dart';
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
          PopupMenuItem(
            padding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsiveness.sw(context) * 0.036,
                  ),
                  child: const Icon(Icons.person_outline),
                ),
                const Text('Profle & Preferences'),
              ],
            ),
          ),

          // alert settings
          PopupMenuItem(
            padding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.pushNamed(context, '/alertSettings');
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsiveness.sw(context) * 0.036,
                  ),
                  child: const Icon(Icons.notifications_active_outlined),
                ),
                const Text('Alerts'),
              ],
            ),
          ),

          // FOIs settings
          PopupMenuItem(
            padding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsiveness.sw(context) * 0.036,
                  ),
                  child: const Icon(Icons.cases_outlined),
                ),
                const Text('Fields of Interest'),
              ],
            ),
          ),

          // theme
          PopupMenuItem(
            padding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsiveness.sw(context) * 0.036,
                  ),
                  child: const Icon(Icons.palette_outlined),
                ),
                const Text('Theme'),
              ],
            ),
          ),

          // about us
          PopupMenuItem(
            padding: const EdgeInsets.all(0),
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsiveness.sw(context) * 0.036,
                  ),
                  child: const Icon(Icons.info_outline),
                ),
                const Text('About us'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
