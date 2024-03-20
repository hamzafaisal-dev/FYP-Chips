import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    _nameController.text = widget.arguments?['name'];
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
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomIconButton(
              iconSvgPath: AssetPaths.leftArrowIconPath,
              iconWidth: 16.w,
              iconHeight: 16.h,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),

        // save changes button
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.w, 0.h, 20.w, 0.w),
            child: Align(
              alignment: Alignment.centerRight,
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UpdatingUserProfile) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Updating profile...",
                      "info",
                    );
                  }
                  if (state is UserProfileUpdated) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Profile updated successfully!",
                      "success",
                    );

                    BlocProvider.of<AuthCubit>(context)
                        .userUpdated(state.updatedUser);
                    BlocProvider.of<UserCubit>(context)
                        .fetchUserChipsStream(_authenticatedUser!.username);
                    NavigationService.goBack();
                  }
                  if (state is UserProfileUpdateFailed) {
                    HelperWidgets.showSnackbar(
                      context,
                      state.errorMessage,
                      "error",
                    );
                  }
                },
                builder: (context, state) {
                  return TextButton(
                    onPressed: state is UpdatingUserProfile
                        ? null
                        : () {
                            if (_saveChangesFormKey.currentState!.validate()) {
                              BlocProvider.of<UserCubit>(context).updateUser(
                                _authenticatedUser!.copyWith(
                                  name: _nameController.text,
                                ),
                              );
                            }
                          },
                    child: state is UpdatingUserProfile
                        ? const CustomCircularProgressIndicator(
                            width: 13.5,
                            height: 13.5,
                          )
                        : Text(
                            "Save",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
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
          children: [
            // user avatar
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            SizedBox(height: 23.4.h),

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
                      'Your display name',
                      const Icon(Icons.person_outline),
                      null,
                      context,
                      null,
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) => FormValidators.nameValidator(value),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
