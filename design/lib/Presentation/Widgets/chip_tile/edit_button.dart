import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Edit',
      onPressed: () {},
      icon: const Icon(Icons.edit_outlined),
    );
  }
}
