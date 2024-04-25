import 'dart:io';

import 'package:development/business%20logic/blocs/autofill/autofill_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/buttons/autofill_button.dart';
import 'package:development/presentation/widgets/buttons/post_chip_button.dart';
import 'package:development/presentation/widgets/chip_image_container.dart';
import 'package:development/presentation/widgets/chip_image_container2.dart';
import 'package:development/presentation/widgets/custom_dropdowns.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/presentation/widgets/custom_textformfield.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  late ChipModel _chipData;
  String? _chipFileUrl;

  final _addChipFormKey = GlobalKey<FormState>();

  final _chipTitleController = TextEditingController();
  final _companyTitleController = TextEditingController();
  final _chipDetailsController = TextEditingController();
  final _applicationLinkController = TextEditingController();

  final _salaryTitleController = TextEditingController();

  File? _selectedImage;

  DateTime? _chipDeadline;

  bool _isEditable = false;
  bool _autoFillEnabled = true;

  // not used filhaal
  String _chipTitle = '';
  String _companyTitle = '';
  String _chipDescription = '';
  String _applicationLink = '';

  String? _jobMode;
  String? _jobType;
  String? _salary;

  List<String> foi = [];

  void _checkDeadline() {
    if (_chipDeadline == null) {
      HelperWidgets.showSnackbar(
        context,
        'Please select a valid deadline',
        'error',
      );

      return;
    }
  }

  void _createChip() {
    _checkDeadline();

    if (_addChipFormKey.currentState!.validate() && _chipDeadline != null) {
      Map<String, dynamic> newChip = {
        'jobTitle': _chipTitleController.text,
        'companyName': _companyTitleController.text,
        'applicationLink': _applicationLinkController.text,
        'description': _chipDetailsController.text,
        'jobMode': _jobMode,
        'chipFile': widget.arguments!["chipImage"],
        'locations': const [],
        'jobType': _jobType,
        'experienceRequired': 0,
        'deadline': _chipDeadline!,
        'skills': foi,
        'salary': 0.0,
        'currentUser': _authenticatedUser,
      };

      Helpers.logEvent(
        _authenticatedUser.userId,
        "post-chip",
        [newChip.toString(), _authenticatedUser],
      );

      BlocProvider.of<ChipBloc>(context).add(UploadChipEvent(newChip: newChip));
    }
  }

  void _editChip() {
    _checkDeadline();

    if (_addChipFormKey.currentState!.validate() && _chipDeadline != null) {
      ChipModel editedChip = _chipData.copyWith(
        jobTitle: _chipTitleController.text,
        companyName: _companyTitleController.text,
        applicationLink: _applicationLinkController.text,
        description: _chipDetailsController.text,
      );

      Map<String, dynamic> editedChipMap = editedChip.toMap();

      Helpers.logEvent(
        _authenticatedUser.userId,
        "edit-chip",
        [editedChip, _authenticatedUser],
      );

      BlocProvider.of<ChipBloc>(context)
          .add(EditChipEvent(editedChip: editedChipMap));
    }
  }

  void _handleAutofillBtnClick() {
    Map<String, dynamic> chipDetails = {
      'chipDescription': widget.arguments!["chipDetails"],
      'chipFile': widget.arguments!["chipImage"],
    };

    Helpers.logEvent(
      _authenticatedUser.userId,
      "use-autofill",
      [_authenticatedUser],
    );

    BlocProvider.of<AutofillBloc>(context)
        .add(AutofillChipDetailsEvent(chipDetails: chipDetails));
  }

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;

    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    if (widget.arguments != null) {
      // the screen from which user came to this screen
      String routeName = widget.arguments!["routeName"];

      if (routeName == "/add-chip1") {
        if (widget.arguments!["chipDetails"] == '' &&
            widget.arguments!["chipImage"] == null) {
          _autoFillEnabled = false;
        }

        _chipDetailsController.text = widget.arguments!["chipDetails"];
        _selectedImage = widget.arguments!["chipImage"];
      }

      if (routeName == "/viewDetails") {
        _isEditable = true;
        _autoFillEnabled = false;

        _chipData = widget.arguments!["chipData"];

        _chipTitleController.text = _chipData.jobTitle;
        _companyTitleController.text = _chipData.companyName;
        _chipDetailsController.text = _chipData.description!;
        _applicationLinkController.text = _chipData.applicationLink;
        _salaryTitleController.text = _chipData.salary.toString();
        _jobMode = _chipData.jobMode;
        _jobType = _chipData.jobType;
        _chipDeadline = _chipData.deadline;
        _chipFileUrl = _chipData.imageUrl;
      }
    }

    _chipDescription = _chipDetailsController.text;
  }

  @override
  void dispose() {
    _chipDetailsController.dispose();
    _chipTitleController.dispose();
    _companyTitleController.dispose();
    _applicationLinkController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          child: Form(
            key: _addChipFormKey,
            child: BlocConsumer<AutofillBloc, AutofillState>(
              listener: (context, state) {
                if (state is AutofillLoading) {
                  HelperWidgets.showAutofillDialog(
                      context, 'AUTOFILLING UNDERWAY!');
                }

                if (state is AutofillSuccess) {
                  Navigator.pop(context); //removes autofill dialog

                  print(state.autoFillResponse["foi"]);

                  _chipTitleController.text =
                      state.autoFillResponse["job_title"];

                  _companyTitleController.text =
                      state.autoFillResponse["company_name"];
                  _chipDetailsController.text =
                      _chipDetailsController.text == ''
                          ? state.autoFillResponse["description"]
                          : '';
                  _chipDeadline = state.autoFillResponse["deadline"];
                  _applicationLinkController.text =
                      state.autoFillResponse["email"];

                  _jobMode = state.autoFillResponse["mode"] == 'Unknown'
                      ? 'On-site'
                      : state.autoFillResponse["mode"];

                  _jobType = state.autoFillResponse["type"];

                  _salaryTitleController.text =
                      state.autoFillResponse["salary"] == 'Unknown'
                          ? ''
                          : state.autoFillResponse["salary"];

                  foi = state.autoFillResponse["foi"] == 'Unknown'
                      ? <String>[]
                      : state.autoFillResponse["foi"];

                  HelperWidgets.showSnackbar(
                    context,
                    'Autofill Success!🥳',
                    'success',
                  );
                }

                if (state is AutofillError) {
                  Navigator.pop(context); //removes autofill dialog

                  HelperWidgets.showSnackbar(
                    context,
                    state.errorMsg,
                    'error',
                  );
                }
              },
              builder: (context, state) {
                bool goBackEnabled = true;

                return ListView(
                  children: [
                    //

                    // back icon + select image btn + post btn
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        BlocBuilder<ChipBloc, ChipState>(
                          builder: (context, state) {
                            return CustomIconButton(
                              iconSvgPath: AssetPaths.leftArrowIconPath,
                              iconWidth: 16.w,
                              iconHeight: 16.h,
                              onTap: () {
                                if (state is! ChipCreatingState) {
                                  HelperWidgets.showDiscardChangesDialog(
                                    context,
                                    'Discard changes? You\'ll have to fill in the details again',
                                  );
                                }
                              },
                            );
                          },
                        ),

                        // post btn
                        BlocConsumer<ChipBloc, ChipState>(
                          listener: (context, state) {
                            if (state is ChipAddSuccess) {
                              HelperWidgets.showSnackbar(
                                context,
                                'Chip created successfully! 🥳',
                                'success',
                              );

                              // event fired to emit updated user in app
                              BlocProvider.of<AuthCubit>(context)
                                  .userUpdated(state.updatedUser);

                              NavigationService.goBack();
                              NavigationService.routeToReplacementNamed(
                                  '/layout');
                            }
                            if (state is ChipEditSuccess) {
                              HelperWidgets.showSnackbar(
                                context,
                                'Chip edited successfully!🥳',
                                'success',
                              );

                              Navigator.pop(context);
                              NavigationService.routeToReplacementNamed(
                                  '/layout');
                            }
                            if (state is ChipCreatingState) {
                              _autoFillEnabled = false;

                              HelperWidgets.showSnackbar(
                                context,
                                'Creating chip...',
                                'info',
                              );
                            }
                            if (state is ChipEditingState) {
                              _autoFillEnabled = false;

                              HelperWidgets.showSnackbar(
                                context,
                                'Editing chip...',
                                'info',
                              );
                            }
                            if (state is ChipError) {
                              if (state.errorMsg == 'profane') {
                                HelperWidgets.showProfanityDialog(context);
                              } else if (state.errorMsg == 'not-job') {
                                HelperWidgets.showNotJobDialog(context);
                              } else {
                                HelperWidgets.showSnackbar(
                                  context,
                                  state.errorMsg,
                                  'error',
                                );
                              }
                            }
                          },
                          builder: (context, state) {
                            return PostChipButton(
                              isLoading: (state is ChipCreatingState),
                              isEditable: _isEditable,
                              onEditChip: _editChip,
                              onCreateChip: _createChip,
                            );
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // 'Fill out the essentials!'
                    Text(
                      'Fill out the essentials!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 24.sp),
                    ),

                    SizedBox(height: 12.h),

                    // chip title textfield
                    CustomTextFormField(
                      controller: _chipTitleController,
                      label: ' Chip Title ',
                      validatorFunction: (value) =>
                          FormValidators.chipValidator(value),
                      onValueChanged: (value) => _chipTitle = value,
                    ),

                    SizedBox(height: 20.h),

                    // company title textfield
                    CustomTextFormField(
                      controller: _companyTitleController,
                      label: ' Company Title ',
                      validatorFunction: (value) =>
                          FormValidators.chipValidator(value),
                      onValueChanged: (value) => _companyTitle = value,
                    ),

                    SizedBox(height: 20.h),

                    CustomTextFormField(
                      controller: _applicationLinkController,
                      label: ' Where To Apply ',
                      toolTipMessage:
                          'This can be a url, a phone number or an email',
                      suffixIcon: const Icon(Icons.info_outline_rounded),
                      validatorFunction: (value) =>
                          FormValidators.chipLinkValidator(value),
                      onValueChanged: (value) {
                        goBackEnabled = !goBackEnabled;

                        _applicationLink = value;
                      },
                    ),

                    SizedBox(height: 20.h),

                    // select chip deadline
                    InkWell(
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          helpText: 'Select Chip Deadline',
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year, 12, 31),
                        );

                        if (selectedDate != null &&
                            selectedDate != _chipDeadline) {
                          setState(() => _chipDeadline = selectedDate);
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          IconButton(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            visualDensity: VisualDensity.compact,
                            focusColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            disabledColor:
                                Theme.of(context).colorScheme.onSecondary,
                            onPressed: null,
                            icon: const Icon(Icons.calendar_month),
                            iconSize: 27.sp,
                          ),

                          Text(
                            _chipDeadline == null
                                ? 'Select Chip Deadline'
                                : 'Chip Deadline: ${DateFormat.yMMMMd().format(_chipDeadline!)}',
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Divider(
                      height: 10.h,
                      color: Theme.of(context).colorScheme.surface,
                      thickness: 10,
                    ),

                    SizedBox(height: 20.h),

                    // 'Want to add a few more details?'
                    Text(
                      'Want to add a few more details?',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 23.sp),
                    ),

                    SizedBox(height: 12.h),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        //
                        Expanded(
                          flex: 4,
                          child: JobModeDropdown(
                            hintText: ' Job Mode ',
                            value: _jobMode,
                            onValueChanged: (value) => _jobMode = value,
                          ),
                        ),

                        SizedBox(width: 10.w),

                        Expanded(
                          flex: 6,
                          child: JobTypeDropdown(
                            hintText: ' Job Type ',
                            value: _jobType,
                            onValueChanged: (value) => _jobType = value,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // salary textfield
                    CustomTextFormField(
                      controller: _salaryTitleController,
                      label: ' Salary ',
                      keyBoardInputType: TextInputType.number,
                      onValueChanged: (value) => _salary = value,
                    ),

                    SizedBox(height: 20.h),

                    // 'CHIP DETAILS'
                    if (_chipDetailsController.text != '')
                      Text(
                        'CHIP DETAILS:',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(fontSize: 23.sp),
                      ),

                    // chip description
                    if (_chipDetailsController.text != '')
                      TextField(
                        readOnly: !_isEditable,
                        // autofocus: true,
                        controller: _chipDetailsController,
                        decoration:
                            const InputDecoration.collapsed(hintText: null),
                        scrollPadding: const EdgeInsets.all(20.0),
                        minLines:
                            (_selectedImage == null && _chipFileUrl == null)
                                ? 8
                                : 1,
                        maxLines: 12,
                      ),

                    const SizedBox(height: 10),

                    // chip image container
                    if (_selectedImage != null || _chipFileUrl != null)
                      _isEditable
                          ? ChipNetworkImageContainer(imageUrl: _chipFileUrl)
                          : ChipImageContainer(selectedImage: _selectedImage!),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<ChipBloc, ChipState>(
        builder: (context, state) {
          return AutofillButton(
            autoFillEnabled:
                (state is ChipCreatingState) ? false : _autoFillEnabled,
            handleAutofillBtnClick: _handleAutofillBtnClick,
          );
        },
      ),
    );
  }
}
