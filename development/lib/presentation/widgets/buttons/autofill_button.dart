import 'package:flutter/material.dart';

class AutofillButton extends StatefulWidget {
  const AutofillButton({
    super.key,
    required this.autoFillEnabled,
    required this.handleAutofillBtnClick,
  });

  final bool autoFillEnabled;
  final void Function() handleAutofillBtnClick;

  @override
  State<AutofillButton> createState() => _AutofillButtonState();
}

class _AutofillButtonState extends State<AutofillButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: widget.autoFillEnabled
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.tertiary,
      disabledElevation: 0,
      onPressed: widget.autoFillEnabled ? widget.handleAutofillBtnClick : null,
      label: widget.autoFillEnabled
          ? const Text('✨ Autofill with AI ✨')
          : const Text(
              ' Autofill with AI ',
              style: TextStyle(color: Colors.grey),
            ),
    );
  }
}
