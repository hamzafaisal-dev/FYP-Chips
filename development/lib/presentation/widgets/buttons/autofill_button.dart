import 'package:flutter/material.dart';

class AutofillButton extends StatelessWidget {
  const AutofillButton({
    super.key,
    required this.autoFillEnabled,
    required this.handleAutofillBtnClick,
  });

  final bool autoFillEnabled;
  final void Function() handleAutofillBtnClick;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: autoFillEnabled
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.tertiary,
      disabledElevation: 0,
      onPressed: autoFillEnabled ? handleAutofillBtnClick : null,
      label: autoFillEnabled
          ? const Text('✨ Autofill with AI ✨')
          : const Text(
              ' Autofill with AI ',
              style: TextStyle(color: Colors.grey),
            ),
    );
  }
}
