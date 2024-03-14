import 'dart:io';

import 'package:development/business%20logic/blocs/autofill/autofill_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_image_container.dart';
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

  final _chipTitleController = TextEditingController();
  final _companyTitleController = TextEditingController();
  final _chipDetailsController = TextEditingController();

  File? _selectedImage;

  String _chipTitle = '';
  String _companyTitle = '';
  final String _applicationLink = '';

  DateTime? _chipDeadline;

  void _createChip() {
    if (_chipDeadline == null) {
      HelperWidgets.showSnackbar(
        context,
        'Please select a valid deadline',
        'error',
      );

      return;
    }

    if (_addChipFormKey.currentState!.validate() && _chipDeadline != null) {
      Map<String, dynamic> newChip = {
        'jobTitle': _chipTitle,
        'companyName': _companyTitle,
        'applicationLink': _applicationLink,
        'description': widget.arguments!["chipDetails"],
        'jobMode': '',
        'chipFile': widget.arguments!["chipImage"],
        'locations': const [],
        'jobType': '',
        'experienceRequired': 0,
        'deadline': _chipDeadline!,
        'skills': const [],
        'salary': 0.0,
        'currentUser': _authenticatedUser,
      };

      BlocProvider.of<ChipBloc>(context).add(UploadChipEvent(newChip: newChip));
    }
  }

  void _handleAutofillBtnClick() {
    Map<String, dynamic> chipDetails = {
      'chipDescription': widget.arguments!["chipDetails"],
      'chipFile': widget.arguments!["chipImage"],
    };

    BlocProvider.of<AutofillBloc>(context)
        .add(AutofillChipDetailsEvent(chipDetails: chipDetails));
  }

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;

    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    if (widget.arguments != null) {
      _chipDetailsController.text = widget.arguments!["chipDetails"];
      _selectedImage = widget.arguments!["chipImage"];
    }
  }

  @override
  void dispose() {
    _chipDetailsController.dispose();
    _chipTitleController.dispose();
    _companyTitleController.dispose();

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
          child: Form(
            key: _addChipFormKey,
            child: ListView(
              children: [
                //

                // back icon + select image btn + post btn
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

                    // post btn
                    BlocConsumer<ChipBloc, ChipState>(
                      listener: (context, state) {
                        if (state is ChipSuccess) {
                          HelperWidgets.showSnackbar(
                            context,
                            'Chip created successfully!',
                            'success',
                          );

                          // Navigator.pop(context);
                          NavigationService.routeToReplacementNamed('/layout');
                        }

                        if (state is ChipsLoading) {
                          HelperWidgets.showSnackbar(
                            context,
                            'creating chip...',
                            'info',
                          );
                        }

                        if (state is ChipError) {
                          HelperWidgets.showSnackbar(
                            context,
                            state.errorMsg,
                            'error',
                          );
                        }
                      },
                      builder: (context, state) {
                        return OutlinedButton(
                          onPressed: () => _createChip(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                                Theme.of(context).colorScheme.onSecondary,
                            backgroundColor: Colors.white,
                          ),
                          child: const Text('POST'),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 'We just need a few more details!'
                Text(
                  'We just need a few more details!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 22),
                ),

                const SizedBox(height: 12),

                // chip title textfield
                CustomTextFormField(
                  controller: _chipTitleController,
                  label: ' Chip Title ',
                  validatorFunction: (value) {
                    _chipTitle = value;

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // company title textfield
                CustomTextFormField(
                  controller: _companyTitleController,
                  label: ' Company Title ',
                  validatorFunction: (value) {
                    _companyTitle = value;

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // select chip deadline
                Row(
                  children: [
                    //
                    IconButton(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      visualDensity: VisualDensity.compact,
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          helpText: 'Select Chip Deadline',
                          context: context,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(2025),
                        );

                        if (selectedDate != null &&
                            selectedDate != _chipDeadline) {
                          setState(() => _chipDeadline = selectedDate);
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                      iconSize: 26,
                    ),

                    Text(
                      _chipDeadline == null
                          ? 'Select Chip Deadline'
                          : 'Chip Deadline: ${DateFormat.yMMMMd().format(_chipDeadline!)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 'CHIP DETAILS'
                Text(
                  'CHIP DETAILS',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 22),
                ),

                // chip description
                TextField(
                  readOnly: true,
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

                const SizedBox(height: 10),

                // chip image container
                if (_selectedImage != null)
                  ChipImageContainer(selectedImage: _selectedImage!),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: BlocConsumer<AutofillBloc, AutofillState>(
        listener: (context, state) {
          if (state is AutofillSuccess) {
            setState(() {
              _chipTitleController.text = state.autoFillResponse["job_title"];
              _companyTitleController.text =
                  state.autoFillResponse["company_name"];
            });

            HelperWidgets.showSnackbar(
              context,
              'autofill success',
              'success',
            );
          }

          if (state is AutofillLoading) {
            HelperWidgets.showSnackbar(
              context,
              'autofill horia',
              'info',
            );
          }

          if (state is AutofillError) {
            HelperWidgets.showSnackbar(
              context,
              state.errorMsg,
              'error',
            );
          }
        },
        builder: (context, state) {
          return FloatingActionButton.extended(
            backgroundColor: (state is AutofillSuccess)
                ? Theme.of(context).colorScheme.tertiary
                : Theme.of(context).colorScheme.onPrimary,
            disabledElevation: 0,
            onPressed:
                (state is AutofillSuccess) ? null : _handleAutofillBtnClick,
            label: const Text('✨ Autofill with AI ✨'),
          );
        },
      ),
    );
  }
}
