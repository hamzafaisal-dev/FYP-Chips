import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.onPressed,
    required this.dialogTitle,
    required this.buttonOneText,
    required this.buttonTwoText,
  });

  final String dialogTitle;
  final String buttonOneText;
  final String buttonTwoText;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Text(
            dialogTitle,
            style: const TextStyle(fontSize: 18),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.9,
                child: FilledButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonOneText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width / 2.9,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    buttonTwoText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
