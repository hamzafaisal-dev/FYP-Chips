import 'package:flutter/material.dart';

class OtpSentDialog extends StatelessWidget {
  const OtpSentDialog({
    super.key,
    required this.email,
    required this.onProceed,
  });

  final String email;
  final void Function() onProceed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'OTP Sent',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'An OTP has been sent to:\n\n',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text: email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            TextSpan(
              text:
                  '\n\nPlease proceed to verify your email and complete your sign up.\n\n',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text:
                  'Note: Please check your email inbox, including your spam/junk folder, for the OTP. If you cannot find the email, please ensure you entered the correct email address and try again.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.63),
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        TextButton(
          // onPressed: () {
          //   Navigator.pop(context);
          //   NavigationService.routeToReplacementNamed(
          //     '/otp',
          //     arguments: {
          //       "email": email,
          //       // add more args here. eg: "password": password
          //     },
          //   );
          // },
          onPressed: onProceed,
          child: Text(
            'Proceed',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
