import 'package:development/constants/custom_colors.dart';
import 'package:flutter/material.dart';

InputDecoration dropdownDecoration(String hintText) {
  return InputDecoration(
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide.none,
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      borderSide: BorderSide(color: Colors.red),
    ),
    filled: true,
    fillColor: Colors.white,
    hintText: hintText,
    hintStyle: const TextStyle(
      fontFamily: 'ManropeRegular',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: CustomColors.darkPurple,
    ),
  );
}

class JobModeDropdown extends StatelessWidget {
  const JobModeDropdown({
    super.key,
    this.value,
    required this.hintText,
    required this.onValueChanged,
  });

  final String? value;
  final String hintText;
  final void Function(String value) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      dropdownColor: Colors.white,
      decoration: dropdownDecoration(hintText),
      items: const [
        DropdownMenuItem(value: 'On-site', child: Text('On-site')),
        DropdownMenuItem(value: 'Hybrid', child: Text('Hybrid')),
        DropdownMenuItem(value: 'Remote', child: Text('Remote')),
      ],
      onChanged: (value) => onValueChanged(value ?? ''),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please select a job mode';
      //   }
      //   return null;
      // },
    );
  }
}

class JobTypeDropdown extends StatelessWidget {
  const JobTypeDropdown({
    super.key,
    this.value,
    required this.hintText,
    required this.onValueChanged,
  });

  final String? value;

  final String hintText;
  final void Function(String value) onValueChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      dropdownColor: Colors.white,
      decoration: dropdownDecoration(hintText),
      items: const [
        DropdownMenuItem(value: 'Internship', child: Text('Internship')),
        DropdownMenuItem(
            value: 'Management Trainee', child: Text('Management Trainee')),
        DropdownMenuItem(value: 'Contract', child: Text('Contract')),
        DropdownMenuItem(value: 'Entry-Level', child: Text('Entry-Level')),
        DropdownMenuItem(value: 'Mid-Level', child: Text('Mid-Level')),
        DropdownMenuItem(value: 'Senior', child: Text('Senior')),
        DropdownMenuItem(value: 'Other', child: Text('Other')),
      ],
      onChanged: (value) => onValueChanged(value ?? ''),
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please select a job type';
      //   }
      //   return null;
      // },
    );
  }
}
