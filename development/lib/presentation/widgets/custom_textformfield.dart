import 'package:development/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    required this.validatorFunction,
  });

  final String label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?) validatorFunction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final _textFormFieldController = TextEditingController();

  @override
  void dispose() {
    _textFormFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textFormFieldController,
      decoration: TextFormFieldStyles.textFormFieldDecoration(
        widget.label,
        widget.prefixIcon,
        widget.suffixIcon,
        context,
      ),
      validator: (value) {
        if (value == null || value == '') {
          return 'Enter a valid value';
        }

        return widget.validatorFunction(value);
      },
    );
  }
}
