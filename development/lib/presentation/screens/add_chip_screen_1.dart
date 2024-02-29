import 'dart:io';

import 'package:development/constants/asset_paths.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class AddChipScreen1 extends StatefulWidget {
  const AddChipScreen1({super.key});

  @override
  State<AddChipScreen1> createState() => _AddChipScreen1State();
}

class _AddChipScreen1State extends State<AddChipScreen1> {
  File? _selectedImage;

  final _chipDetailsController = TextEditingController();

  void _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: ListView(
            children: [
              //
              Column(
                children: [
                  // back icon + select image btn + next btn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      CustomIconButton(
                        iconSvgPath: AssetPaths.leftArrowIconPath,
                        iconWidth: 16.w,
                        iconHeight: 16.h,
                        onTap: () => Navigator.of(context).pop(),
                      ),

                      // select image btn + next btn
                      Row(
                        children: [
                          //
                          IconButton(
                            onPressed: _selectedImage == null
                                ? () => _selectImage()
                                : null,
                            iconSize: 28,
                            icon: const Icon(Icons.add_a_photo),
                            disabledColor: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                          ),

                          const SizedBox(width: 5),

                          OutlinedButton(
                            onPressed: () {
                              if (_chipDetailsController.text != '') {
                                NavigationService.routeToNamed(
                                  '/add-chip2',
                                  arguments: {
                                    "chipImage": _selectedImage,
                                    "chipDetails": _chipDetailsController.text,
                                  },
                                );
                              }
                            },
                            child: const Text('NEXT'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: _selectedImage == null
                        ? MediaQuery.of(context).size.height
                        : 200,
                    child: TextField(
                      controller: _chipDetailsController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Paste chip sauce here",
                        hintStyle:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .color!
                                      .withOpacity(0.5),
                                ),
                      ),
                      scrollPadding: const EdgeInsets.all(20.0),
                      autofocus: true,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (_selectedImage != null)
                Stack(
                  children: [
                    //
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.contain,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                      ),
                    ),

                    Positioned(
                      top: 15,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            //
                            OutlinedButton(
                              onPressed: () => _selectImage(),
                              child: const Text(
                                "Select Another",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            IconButton(
                              onPressed: () => _removeImage(),
                              icon: const Icon(Icons.close),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
