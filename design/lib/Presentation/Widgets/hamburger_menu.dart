import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/contact_us.dart';
import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = Responsiveness.sw(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // settings
        // PopupMenuItem(
        //   padding: const EdgeInsets.all(0),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/settings');
        //   },
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: sw * 0.036,
        //         ),
        //         child: const Icon(Icons.settings_outlined),
        //       ),
        //       const Text('Settings'),
        //     ],
        //   ),
        // ),

        // settings list tile
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Settings'),
        ),

        // bin
        // PopupMenuItem(
        //   padding: const EdgeInsets.all(0),
        //   onTap: () {
        //     Navigator.pushNamed(context, '/bin');
        //   },
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: sw * 0.036,
        //         ),
        //         child: const Icon(Icons.delete_outline),
        //       ),
        //       const Text('Bin'),
        //     ],
        //   ),
        // ),

        // bin list tile
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/bin');
          },
          leading: const Icon(Icons.delete_outline),
          title: const Text('Bin'),
        ),

        // contact us
        // PopupMenuItem(
        //   padding: const EdgeInsets.all(0),
        //   onTap: () {
        //     showModalBottomSheet(
        //       isScrollControlled: true,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.only(
        //           topLeft: Radius.circular(sw * 0.063),
        //           topRight: Radius.circular(sw * 0.063),
        //         ),
        //       ),
        //       context: context,
        //       builder: (context) => Padding(
        //         padding: EdgeInsets.only(
        //           bottom: MediaQuery.of(context).viewInsets.bottom,
        //         ),
        //         child: const ContactUs(),
        //       ),
        //     );
        //   },
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: sw * 0.036,
        //         ),
        //         child: const Icon(Icons.mail_outline_rounded),
        //       ),
        //       const Text('Contact us'),
        //     ],
        //   ),
        // ),

        // contact us list tile
        ListTile(
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
          leading: const Icon(Icons.mail_outline_rounded),
          title: const Text('Contact us'),
        ),

        // log out
        // PopupMenuItem(
        //   padding: const EdgeInsets.all(0),
        // onTap: () => showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     title: const Text('Log out'),
        //     content: const Text('Are you sure you want to log out?'),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: const Text('Cancel'),
        //       ),
        //       TextButton(
        //         onPressed: () {},
        //         child: const Text(
        //           'Log out',
        //           style: TextStyle(
        //             color: Colors.red,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        //   child: Row(
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.symmetric(
        //           horizontal: sw * 0.036,
        //         ),
        //         child: const Icon(
        //           Icons.logout,
        //           color: Colors.red,
        //         ),
        //       ),
        //       const Text(
        //         'Log out',
        //         style: TextStyle(
        //           color: Colors.red,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // log out list tile
        ListTile(
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
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            'Log out',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
