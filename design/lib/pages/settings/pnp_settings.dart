import 'package:flutter/material.dart';

class PNPSettings extends StatelessWidget {
  const PNPSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Profile & Preferences'),
        centerTitle: true,
      ),
    );
  }
}
