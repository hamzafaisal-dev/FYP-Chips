import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/custom_colors.dart';
import 'package:development/constants/styles.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/presentation/widgets/custom_dialog.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final UserModel? _authenticatedUser;
  final _nameController = TextEditingController();
  final _saveChangesFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;
    _nameController.text = _authenticatedUser!.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _saveChangesFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,

        // back button
        leadingWidth: 64.w,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return CustomIconButton(
                  iconSvgPath: AssetPaths.leftArrowIconPath,
                  iconWidth: 16.w,
                  iconHeight: 16.h,
                  onTap: state is UpdatingUserProfile
                      ? null
                      : () {
                          // if user has made changes, show alert dialog
                          if (_nameController.text !=
                              _authenticatedUser!.name) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  dialogTitle: 'Discard Changes?',
                                  dialogContent:
                                      'Discard changes made to your display name?',
                                  buttonOneText: 'Cancel',
                                  buttonTwoText: 'Discard',
                                  buttonOneOnPressed: () =>
                                      NavigationService.goBack(),
                                  buttonTwoOnPressed: () {
                                    NavigationService.goBack();
                                    NavigationService.goBack();
                                  },
                                );
                              },
                            );
                          } else {
                            NavigationService.goBack();
                          }
                        },
                );
              },
            ),
          ),
        ),

        // save changes button
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.w, 0.h, 20.w, 0.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserProfileUpdated) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Profile updated successfully!🥳",
                      "success",
                    );

                    BlocProvider.of<AuthCubit>(context)
                        .userUpdated(state.updatedUser);

                    BlocProvider.of<UserCubit>(context)
                        .fetchUserChipsStream(_authenticatedUser!.username);

                    NavigationService.goBack();
                    NavigationService.goBack();
                    NavigationService.routeToNamed("/user_profile");
                  }
                  if (state is UserProfileUpdateFailed) {
                    HelperWidgets.showSnackbar(
                      context,
                      state.errorMessage,
                      "error",
                    );
                    BlocProvider.of<UserCubit>(context)
                        .fetchUserChipsStream(_authenticatedUser!.username);
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: state is UpdatingUserProfile
                        ? null
                        : () {
                            if (_saveChangesFormKey.currentState!.validate()) {
                              if (_nameController.text ==
                                  _authenticatedUser!.name) {
                                HelperWidgets.showSnackbar(
                                  context,
                                  "No changes made!🫲🏼🥸🫱🏼",
                                  "info",
                                );
                              } else {
                                BlocProvider.of<UserCubit>(context).updateUser(
                                  _authenticatedUser!.copyWith(
                                    name: _nameController.text,
                                  ),
                                );
                              }
                            }
                          },
                    child: state is UpdatingUserProfile
                        ? CustomCircularProgressIndicator(
                            width: 13.5.w,
                            height: 13.5.h,
                            color: CustomColors.darkPurple,
                          )
                        : Text(
                            "Save",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // user avatar
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: ClipOval(
                  child: SvgPicture.network(
                    _authenticatedUser!.profilePictureUrl,
                  ),
                ),
              ),
            ),

            SizedBox(height: 23.4.h),

            // your display name
            Text(
              'Your Display Name',
              style: Theme.of(context).textTheme.labelMedium,
            ),

            SizedBox(height: 10.h),

            // edit profile form
            Form(
              key: _saveChangesFormKey,
              child: Column(
                children: [
                  // user name
                  TextFormField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _nameController,
                    decoration: Styles.textFormFieldDecoration(
                      'Your Display Name',
                      const Icon(Icons.person_outline),
                      null,
                      context,
                      null,
                      null,
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) => FormValidators.nameValidator(value),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // change password button
            FilledButton(
              onPressed: () {
                NavigationService.routeToNamed("/change-password");
              },
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}
