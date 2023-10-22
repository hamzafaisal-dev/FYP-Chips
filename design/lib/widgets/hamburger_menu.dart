import 'package:design/responsiveness.dart';
import 'package:design/widgets/contact_us.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = Responsiveness.sw(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // // punga
        // Padding(
        //   padding: EdgeInsets.only(
        //     top: sw * 0.036,
        //     bottom: sw * 0.018,
        //   ),
        //   child: Container(
        //     width: sw * 0.09,
        //     height: sw * 0.0108,
        //     decoration: BoxDecoration(
        //       color: Theme.of(context).hintColor,
        //       borderRadius: BorderRadius.all(Radius.circular(sw * 0.09)),
        //     ),
        //   ),
        // ),

        // settings
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.036,
                ),
                child: const Icon(Icons.settings_outlined),
              ),
              const Text('Settings'),
            ],
          ),
        ),

        // bin
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          onTap: () {
            Navigator.pushNamed(context, '/bin');
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.036,
                ),
                child: const Icon(Icons.delete_outline),
              ),
              const Text('Bin'),
            ],
          ),
        ),

        // contact us
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sw * 0.063),
                  topRight: Radius.circular(sw * 0.063),
                ),
              ),
              context: context,
              builder: (context) => Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const ContactUs(),
              ),
            );
          },
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.036,
                ),
                child: const Icon(Icons.mail_outline_rounded),
              ),
              const Text('Contact us'),
            ],
          ),
        ),

        // log out
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          onTap: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Log out'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Log out',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sw * 0.036,
                ),
                child: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
              const Text(
                'Log out',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: sw * 0.036,
        ),
      ],
    );
  }
}
