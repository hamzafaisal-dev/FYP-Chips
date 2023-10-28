import 'package:design/responsiveness.dart';
import 'package:flutter/material.dart';

class MoreOptionsButton extends StatefulWidget {
  const MoreOptionsButton({super.key});

  @override
  State<MoreOptionsButton> createState() => _MoreOptionsButtonState();
}

class _MoreOptionsButtonState extends State<MoreOptionsButton> {
  // // pressed or not
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    // screen width
    double sw = Responsiveness.sw(context);

    // popup menu button
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(sw * 0.036),
        ),
      ),
      position: PopupMenuPosition.under,
      tooltip: 'More options',
      // onOpened: () {
      //   setState(() {
      //     isPressed = true;
      //   });
      // },
      // onCanceled: () {
      //   setState(() {
      //     isPressed = false;
      //   });
      // },
      // icon: isPressed
      //     ? const Icon(Icons.expand_less)
      //     : const Icon(Icons.expand_more),
      // icon: isPressed
      //     ? const Icon(Icons.keyboard_arrow_down)
      //     : const Icon(Icons.keyboard_arrow_left),
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Tooltip(
            message: 'Apply directly',
            child: Row(
              children: [
                const Icon(
                  Icons.open_in_new_outlined,
                ),
                SizedBox(width: sw * 0.018),
                const Text('Apply Now'),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/chipDetails',
            );
          },
          child: Tooltip(
            message: 'Show more details',
            child: Row(
              children: [
                const Icon(Icons.info_outline),
                SizedBox(width: sw * 0.018),
                const Text('Details'),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: Tooltip(
            message: "Mark as Applied",
            child: Row(
              children: [
                const Icon(Icons.history),
                SizedBox(width: sw * 0.018),
                const Text('Applied'),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: Tooltip(
            message: 'Move to bin',
            child: Row(
              children: [
                const Icon(Icons.delete_outline_rounded),
                SizedBox(width: sw * 0.018),
                const Text('Bin'),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: Tooltip(
            message: 'Help us keep our app safe',
            child: Row(
              children: [
                const Icon(Icons.report_outlined, color: Colors.red),
                SizedBox(width: sw * 0.018),
                const Text(
                  'Report',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
