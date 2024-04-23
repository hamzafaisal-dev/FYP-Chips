import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final UserModel? _authenticatedUser;

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  final _changePasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    _changePasswordFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        title: const Text('Change Password'),
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
                  onTap: state is UpdatingUserPassword
                      ? null
                      : () => NavigationService.goBack(),
                );
              },
            ),
          ),
        ),
      ),

      // body
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 18.h),

              // form containing the fields
              Form(
                key: _changePasswordFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // old password form field
                    TextFormField(
                      decoration: Styles.textFormFieldDecoration(
                        'Old Password',
                        const Icon(Icons.lock_outline),
                        IconButton(
                          onPressed: () {
                            setState(() =>
                                _isOldPasswordVisible = !_isOldPasswordVisible);
                          },
                          icon: _isOldPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        context,
                        null,
                        null,
                      ),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      obscureText: !_isOldPasswordVisible,
                      validator: (value) =>
                          FormValidators.passwordValidator(value),
                      controller: _oldPasswordController,
                    ),

                    SizedBox(height: 8.h),

                    // new password form field
                    TextFormField(
                      decoration: Styles.textFormFieldDecoration(
                        'New Password',
                        const Icon(Icons.lock_outline),
                        IconButton(
                          onPressed: () {
                            setState(() =>
                                _isNewPasswordVisible = !_isNewPasswordVisible);
                          },
                          icon: _isNewPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        context,
                        null,
                        null,
                      ),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      obscureText: !_isNewPasswordVisible,
                      validator: (value) =>
                          FormValidators.passwordValidator(value),
                      controller: _newPasswordController,
                    ),

                    SizedBox(height: 8.h),

                    // confirm new password form field
                    TextFormField(
                      decoration: Styles.textFormFieldDecoration(
                        'Confirm New Password',
                        const Icon(Icons.lock_outline),
                        IconButton(
                          onPressed: () {
                            setState(() => _isConfirmNewPasswordVisible =
                                !_isConfirmNewPasswordVisible);
                          },
                          icon: _isConfirmNewPasswordVisible
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                        ),
                        context,
                        null,
                        null,
                      ),
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      obscureText: !_isConfirmNewPasswordVisible,
                      validator: (value) =>
                          FormValidators.confirmPasswordValidator(
                              value, _newPasswordController.text),
                      controller: _confirmNewPasswordController,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 28.h),

              // save changes button
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserPasswordUpdated) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Password updated successfully!🔐",
                      "success",
                    );
                    BlocProvider.of<UserCubit>(context)
                        .fetchUserChipsStream(_authenticatedUser!.username);
                    Helpers.logEvent(
                      _authenticatedUser!.userId,
                      "change-password",
                      [_authenticatedUser],
                    );
                    NavigationService.goBack();
                  }
                  if (state is UserPasswordUpdateFailed) {
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
                  return FilledButton(
                    onPressed: state is UpdatingUserPassword
                        ? null
                        : () {
                            if (_changePasswordFormKey.currentState!
                                .validate()) {
                              BlocProvider.of<UserCubit>(context)
                                  .updateUserPassword(
                                _oldPasswordController.text,
                                _newPasswordController.text,
                              );
                            }
                          },
                    child: state is UpdatingUserPassword
                        ? const CustomCircularProgressIndicator()
                        : const Text('Save Changes'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
