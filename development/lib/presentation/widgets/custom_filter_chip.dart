import 'package:flutter/material.dart';

class CustomFilterChip extends StatefulWidget {
  const CustomFilterChip({
    super.key,
    required this.chipLabel,
    required this.selectedChips,
    required this.onPressed,
  });

  final String chipLabel;
  final List<String> selectedChips;
  final void Function(String value) onPressed;

  @override
  State<CustomFilterChip> createState() => _CustomFilterChipState();
}

class _CustomFilterChipState extends State<CustomFilterChip> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    _isSelected = widget.selectedChips.contains(widget.chipLabel);

    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });

        widget.onPressed(widget.chipLabel);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        child: Chip(
          label: Text(
            widget.chipLabel,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: _isSelected
                  ? Theme.of(context).colorScheme.onSecondaryContainer
                  : Colors.white,
            ),
          ),
          backgroundColor: _isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.grey[60],
          elevation: 1.0,
          padding: const EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
