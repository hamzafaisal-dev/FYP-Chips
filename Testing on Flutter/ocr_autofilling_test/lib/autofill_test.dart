import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class AutofillTestPage extends StatefulWidget {
  const AutofillTestPage({super.key});

  @override
  State<AutofillTestPage> createState() => _AutofillTestPageState();
}

class _AutofillTestPageState extends State<AutofillTestPage> {
  File? selectedImage;

  Widget buildUI() {
    return ListView(
      children: [
        _imageView(),
        _extractTextView(),
      ],
    );
  }

  Widget _imageView() {
    if (selectedImage == null) {
      return const Center(
        child: Text("No image"),
      );
    }
    return Center(
      child: Image.file(selectedImage!),
    );
  }

  Widget _extractTextView() {
    if (selectedImage == null) {
      return const Center(
        child: Text("No text"),
      );
    }
    return FutureBuilder(
        future: _extractText(selectedImage!),
        builder: (context, snapshot) {
          return Text(snapshot.data ?? "");
        });
  }

  Future<String>? _extractText(File image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFile(image);
    final RecognizedText recognisedText =
        await textRecognizer.processImage(inputImage);
    String extractedText = recognisedText.text;
    textRecognizer.close();
    return extractedText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<MediaFile>? media = await GalleryPicker.pickMedia(
              context: context, singleMedia: true);
          if (media != null && media.isNotEmpty) {
            var data = await media.first.getFile();
            setState(() {
              selectedImage = data;
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
