import 'dart:io';

import 'package:flutter/material.dart';

class ChipImageContainer extends StatefulWidget {
  const ChipImageContainer({
    super.key,
    required this.selectedImage,
  });

  final File selectedImage;

  @override
  State<ChipImageContainer> createState() => _ChipImageContainerState();
}

class _ChipImageContainerState extends State<ChipImageContainer> {
  void showPictureFullScreen(File selectedImage) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog.fullscreen(
            backgroundColor: Colors.black38,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.file(selectedImage),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.topRight,
                    color: Colors.black45,
                    height: 40,
                    width: 400,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showPictureFullScreen(widget.selectedImage),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Image.file(
          widget.selectedImage,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
