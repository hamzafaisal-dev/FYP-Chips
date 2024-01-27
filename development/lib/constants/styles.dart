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
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Colors.grey,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).colorScheme.error,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.5,
          color: Theme.of(context).colorScheme.error,
        ),
      ),

      floatingLabelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),

      floatingLabelBehavior: FloatingLabelBehavior.never,

      prefixIcon: prefixIcon,

      prefixIconConstraints: prefixIcon != null
          ? const BoxConstraints.tightFor(width: 40)
          : const BoxConstraints.tightFor(width: 12),

      suffixIcon: suffixIcon,

      labelText: labelText,
    );
  }
}
