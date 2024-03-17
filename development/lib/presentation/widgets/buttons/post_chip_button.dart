import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class PostChipButton extends StatefulWidget {
  const PostChipButton({
    super.key,
    required this.isLoading,
    required this.isEditable,
    required this.onEditChip,
    required this.onCreateChip,
  });

  final bool isLoading;
  final bool isEditable;
  final void Function() onEditChip;
  final void Function() onCreateChip;

  @override
  State<PostChipButton> createState() => _PostChipButtonState();
}

class _PostChipButtonState extends State<PostChipButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: (widget.isLoading)
          ? null
          : (widget.isEditable ? widget.onEditChip : widget.onCreateChip),
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Colors.white,
      ),
      child: (widget.isLoading)
          ? const CustomCircularProgressIndicator()
          : (widget.isEditable ? const Text('EDIT') : const Text('POST')),
    );
  }
}
