import 'package:flutter/material.dart';

class AuthScreensBottomRow extends StatelessWidget {
  const AuthScreensBottomRow({
    super.key,
    required this.label1,
    required this.label2,
    required this.onTap,
  });

  final String label1;
  final String label2;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label1,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            label2,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
