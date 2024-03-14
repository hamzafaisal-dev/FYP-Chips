import 'package:development/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.initialText,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.validatorFunction,
  });

  final String label;
  final TextEditingController controller;

  final String? initialText;

  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String value) validatorFunction;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
    widget.controller.text = widget.initialText ?? '';
    super.initState();
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: Styles.textFormFieldDecoration(
        widget.label,
        widget.prefixIcon,
        widget.suffixIcon,
        context,
        widget.hintText,
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: (value) {
        if (value == null || value == '') {
          return 'Enter a valid value';
        }
        widget.validatorFunction(value);

        widget.controller.clear();

        return null;
      },
    );
  }
}
