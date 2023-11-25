import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/chip_tile/more_options_button.dart';
import 'package:flutter/material.dart';

class ChipTile extends StatefulWidget {
  final Widget actionButton;
  final String deadline;
  final String title, subtitle;
  final bool isToday;
  const ChipTile({
    super.key,
    required this.deadline,
    required this.title,
    required this.subtitle,
    required this.actionButton,
    required this.isToday,
  });

  @override
  State<ChipTile> createState() => _ChipTileState();
}

class _ChipTileState extends State<ChipTile> {
  @override
  Widget build(BuildContext context) {
    // screen width
    double sw = Responsiveness.sw(context);
    // chip side padding
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.009,
      ),
      // card
      child: Card(
        elevation: 1.8,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/chipDetails');
          },
          child: Row(
            children: [
              Expanded(
                // tile
                child: ListTile(
                  leading: widget.isToday
                      ? Badge(
                          smallSize: sw * 0.018,
                          child: Tooltip(
                            message: 'Expiring today!',
                            child: CircleAvatar(
                              child: Text(widget.deadline),
                            ),
                          ),
                        )
                      : Tooltip(
                          message: '23rd August',
                          child: CircleAvatar(
                            child: Text(widget.deadline),
                          ),
                        ),
                  title: Text(widget.title),
                  subtitle: Text(widget.subtitle),
                ),
              ),
              // trailing buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.actionButton,
                  const MoreOptionsButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
