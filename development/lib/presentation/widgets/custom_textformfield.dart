import 'package:development/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyBoardInputType,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.toolTipMessage,
    this.validatorFunction,
    required this.onValueChanged,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType? keyBoardInputType;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? toolTipMessage;
  final String? Function(String value)? validatorFunction;
  final void Function(String value) onValueChanged;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  void initState() {
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
      keyboardType: widget.keyBoardInputType ?? TextInputType.text,
      decoration: Styles.textFormFieldDecoration(
        widget.label,
        widget.prefixIcon,
        widget.suffixIcon,
        context,
        widget.hintText,
        widget.toolTipMessage,
      ),
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      validator: (value) {
        if (value == null) return 'Please enter a valid value';

        final validationResult = widget.validatorFunction?.call(value);

        if (validationResult != null) {
          return validationResult;
        }

        widget.onValueChanged(value);

        return null;
      },
    );
  }
}
