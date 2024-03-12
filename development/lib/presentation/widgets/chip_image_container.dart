import 'dart:io';

import 'package:flutter/material.dart';

class ChipImageContainer extends StatelessWidget {
  const ChipImageContainer({
    super.key,
    required this.selectedImage,
  });

  final File selectedImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      child: Image.file(
        selectedImage,
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
      ),
    );
  }
}
