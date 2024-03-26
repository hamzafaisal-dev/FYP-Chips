import 'dart:io';
import 'package:development/constants/asset_paths.dart';
import 'package:development/presentation/widgets/chip_image_container.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_cropper/image_cropper.dart';

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

    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: const Color(0xffffba7c),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() => _selectedImage = File(croppedFile.path));
    }
  }

  void _removeImage() {
    setState(() => _selectedImage = null);
  }

  void _handleNextScreenClick() {
    NavigationService.routeToNamed(
      '/add-chip2',
      arguments: {
        "routeName": "/add-chip1",
        "chipImage": _selectedImage,
        "chipDetails": _chipDetailsController.text
      },
    );
  }

  @override
  void dispose() {
    _chipDetailsController.dispose();
    super.dispose();
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
                        onTap: () => NavigationService.goBack(),
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
                            onPressed: () => _handleNextScreenClick(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              backgroundColor: Colors.white,
                            ),
                            child: const Text('NEXT'),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // chip description textfield
                  TextField(
                    controller: _chipDetailsController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration.collapsed(
                      hintText: "Paste job description here\n(optional)",
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
                    minLines: 1,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (_selectedImage != null)
                Stack(
                  children: [
                    //
                    ChipImageContainer(selectedImage: _selectedImage!),

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
