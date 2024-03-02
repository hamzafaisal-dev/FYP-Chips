import 'dart:io';

import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/presentation/widgets/custom_textformfield.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddChipScreen2 extends StatefulWidget {
  const AddChipScreen2({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<AddChipScreen2> createState() => _AddChipScreen2State();
}

class _AddChipScreen2State extends State<AddChipScreen2> {
  late UserModel _authenticatedUser;

  final _addChipFormKey = GlobalKey<FormState>();

  final _chipDetailsController = TextEditingController();
  File? _selectedImage;

  late String _chipTitle;
  late String _companyTitle;
  DateTime? _chipDeadline = null;

  void _createChip() {
    if (_chipDeadline == null) {
      HelperWidgets.showSnackbar(
        context,
        'Please select a valid deadline',
        'error',
      );
    }

    if (_addChipFormKey.currentState!.validate() && _chipDeadline != null) {
      BlocProvider.of<ChipBloc>(context).add(
        UploadChipEvent(
          jobTitle: _chipTitle,
          companyName: _companyTitle,
          description: widget.arguments!["chipDetails"],
          jobMode: 'on-site',
          chipFile: widget.arguments!["chipImage"],
          locations: const [],
          jobType: 'full-time',
          experienceRequired: 20,
          deadline: _chipDeadline!,
          skills: const [],
          salary: 0,
          updatedUser: _authenticatedUser,
          uploaderAvatar: _authenticatedUser.userName,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.arguments != null) {
      _chipDetailsController.text = widget.arguments!["chipDetails"];
      _selectedImage = widget.arguments!["chipImage"];
    }

    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }
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
          child: BlocConsumer<ChipBloc, ChipState>(
            listener: (context, state) {
              if (state is ChipSuccess) {
                HelperWidgets.showSnackbar(
                  context,
                  'Chip created successfully!',
                  'success',
                );

                NavigationService.routeToReplacementNamed('/layout');
              } else if (state is ChipError) {
                HelperWidgets.showSnackbar(
                  context,
                  state.errorMsg,
                  'error',
                );
              }
            },
            builder: (context, state) {
              return Form(
                key: _addChipFormKey,
                child: ListView(
                  children: [
                    //
                    Column(
                      children: [
                        // back icon + select image btn + post btn
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

                            // post btn
                            OutlinedButton(
                              onPressed: () => _createChip(),
                              child: const Text('POST'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),

                    Text(
                      'We just need a few more details!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 22),
                    ),

                    const SizedBox(height: 12),

                    CustomTextFormField(
                      label: ' Chip Title ',
                      validatorFunction: (value) {
                        _chipTitle = value;

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: ' Company Title ',
                      validatorFunction: (value) {
                        _companyTitle = value;

                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        //
                        IconButton(
                          onPressed: () async {
                            final selectedDate = await showDatePicker(
                              helpText: 'Select Chip Deadline',
                              context: context,
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2025),
                            );

                            if (selectedDate != null &&
                                selectedDate != _chipDeadline) {
                              print(_chipDeadline);
                              setState(() {
                                _chipDeadline = selectedDate;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_month),
                          iconSize: 26,
                        ),

                        // const SizedBox(width: 8),

                        Text(
                          _chipDeadline == null
                              ? 'Select Chip Deadline'
                              : 'Chip Deadline: ${DateFormat.yMMMMd().format(_chipDeadline!)}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'CHIP DETAILS',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 22),
                    ),

                    TextField(
                      readOnly: true,
                      controller: _chipDetailsController,
                      decoration: InputDecoration.collapsed(
                        hintText: "Chip sauce here",
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

                    // const SizedBox(height: 10),

                    if (_selectedImage != null)
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
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
