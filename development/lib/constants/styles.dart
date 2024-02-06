import 'package:flutter/material.dart';

class TextFormFieldStyles {
  static InputDecoration textFormFieldDecoration(
    String labelText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    BuildContext context,
  ) {
    return InputDecoration(
      //
      filled: true,

      fillColor: Theme.of(context).colorScheme.surface,

      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).colorScheme.error,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),

      // floatingLabelStyle: TextStyle(
      //   color: Theme.of(context).colorScheme.onPrimary,
      //   fontWeight: FontWeight.bold,
      // ),

      floatingLabelBehavior: FloatingLabelBehavior.never,

      prefixIcon: prefixIcon,

      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints.tightFor(width: 52)
          : const BoxConstraints.tightFor(width: 12),

      suffixIcon: suffixIcon,

      labelText: labelText,

      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}
