import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class AutofillTestPage extends StatefulWidget {
  const AutofillTestPage({Key? key}) : super(key: key);

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
      },
    );
  }

  Future<String> _extractText(File image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFile(image);
    final RecognizedText recognisedText =
        await textRecognizer.processImage(inputImage);
    String extractedText = recognisedText.text;
    await textRecognizer.close();
    return extractedText;
  }

  Future<void> _sendPostRequest(String context) async {
    final url = Uri.parse('http://127.0.0.1:5000/autofilling');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'context': context}),
    );

    if (response.statusCode == 200) {
      _showResponseModal(response.body);
    } else {
      // Handle error
      print('Failed to send POST request. Status code: ${response.statusCode}');
    }
  }

  void _showResponseModal(String responseBody) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Raw JSON Output:\n$responseBody'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildUI(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final imagePicker = ImagePicker();
              final pickedImage =
                  await imagePicker.pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                setState(() {
                  selectedImage = File(pickedImage.path);
                });
              }
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () async {
              if (selectedImage != null) {
                String extractedText = await _extractText(selectedImage!);
                _sendPostRequest(extractedText);
              }
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
