import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.dialogTitle,
    required this.dialogContent,
    required this.buttonOneText,
    required this.buttonTwoText,
    required this.buttonOneOnPressed,
    required this.buttonTwoOnPressed,
  });

  final String dialogTitle;
  final String dialogContent;
  final String buttonOneText;
  final String buttonTwoText;
  final void Function() buttonOneOnPressed;
  final void Function() buttonTwoOnPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: Text(dialogContent),
      actions: [
        TextButton(
          onPressed: () {
            buttonOneOnPressed();
          },
          child: Text(buttonOneText),
        ),
        TextButton(
          onPressed: () {
            buttonTwoOnPressed();
          },
          child: Text(buttonTwoText),
        ),
      ],
      shadowColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
