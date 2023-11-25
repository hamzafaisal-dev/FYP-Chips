import 'package:flutter/material.dart';

class AlertSettings extends StatefulWidget {
  const AlertSettings({super.key});

  @override
  State<AlertSettings> createState() => _AlertSettingsState();
}

class _AlertSettingsState extends State<AlertSettings> {
  bool _ncaChecked = false;
  bool _foChecked = false;
  bool _pnChecked = true;
  bool _eaChecked = true;

  String _toa = '8 hours before expiry';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Alerts'),
        centerTitle: true,
      ),

      // body
      body: Column(
        children: [
          // time of alerts
          ListTile(
            title: const Text('Time of alerts'),
            trailing: Text(
              _toa,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('2 hours before expiry'),
                        onTap: () {
                          setState(() {
                            _toa = '2 hours before expiry';
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text('8 hours before expiry'),
                        onTap: () {
                          setState(() {
                            _toa = '8 hours before expiry';
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: const Text('24 hours before expiry'),
                        onTap: () {
                          setState(() {
                            _toa = '24 hours before expiry';
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // on day or day before

          // new chip alerts
          SwitchListTile(
            title: const Text('New chip alerts'),
            value: _ncaChecked,
            onChanged: (val) {
              setState(() {
                _ncaChecked = val;
              });
            },
          ),

          // favorite only
          SwitchListTile(
            title: const Text('Favorites only'),
            value: _foChecked,
            onChanged: (val) {
              setState(() {
                _foChecked = val;
              });
            },
          ),

          // push notifications
          SwitchListTile(
            title: const Text('Push notifications'),
            value: _pnChecked,
            onChanged: (val) {
              setState(() {
                _pnChecked = val;
              });
            },
          ),

          // email alerts
          SwitchListTile(
            title: const Text('Email alerts'),
            value: _eaChecked,
            onChanged: (val) {
              setState(() {
                _eaChecked = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
