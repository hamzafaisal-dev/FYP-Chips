import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/presentation/widgets/auth_screens_bottom_row.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          children: [
            // back button
            Align(
              alignment: Alignment.centerLeft,
              child: CustomIconButton(
                iconSvgPath: AssetPaths.leftArrowIconPath,
                iconWidth: 16.5.w,
                iconHeight: 12.h,
                onTap: () => NavigationService.goBack(),
              ),
            ),

            SizedBox(height: 25.h),

            // FORGOT YOUR PASSWORD?
            Text(
              'FORGOT YOUR PASSWORD?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 39.h),

            // Image
            SvgPicture.asset(
              AssetPaths.resetPasswordScreenBannerPath,
              width: double.maxFinite,
              height: 264.h,
            ),

            SizedBox(height: 45.h),

            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color(0XFFFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Enter your registered...
                      Text(
                        'Enter your registered email below to receive password reset instruction',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      SizedBox(height: 30.h),

                      // Email text field
                      TextFormField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        controller: _emailController,
                        decoration: Styles.textFormFieldDecoration(
                          'j.doe.36963@khi.iba.edu.pk',
                          null,
                          null,
                          context,
                          null,
                        ).copyWith(
                          fillColor: const Color(0XFFFFF6ED),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            FormValidators.emailValidator(value),
                      ),

                      SizedBox(height: 10.h),

                      // Send Reset Link button
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthFailureCheckingUserExistance) {
                            HelperWidgets.showSnackbar(
                              context,
                              "Error: ${state.message}",
                              "error",
                            );
                          }
                          if (state is AuthCheckingIfUserAlreadyExists) {}
                          if (state is AuthUserAlreadyExists) {
                            BlocProvider.of<AuthCubit>(context)
                                .sendPasswordResetEmail(
                              _emailController.text.trim(),
                            );
                          }
                          if (state is AuthUserDoesNotExist) {
                            HelperWidgets.showSnackbar(
                              context,
                              "User does not exist.",
                              "error",
                            );
                          }

                          if (state is AuthSendingPasswordResetEmail) {}
                          if (state is AuthPasswordResetEmailSent) {
                            HelperWidgets.showSnackbar(
                              context,
                              "Password reset email sent to ${_emailController.text}",
                              "success",
                            );
                            _emailController.clear();
                          }
                          if (state is AuthPasswordResetEmailFailedToSend) {
                            HelperWidgets.showSnackbar(
                              context,
                              "Failed to send password reset email: ${state.message}",
                              "error",
                            );
                          }
                        },
                        builder: (context, state) {
                          return FilledButton(
                            onPressed: (state
                                        is AuthSendingPasswordResetEmail ||
                                    state is AuthCheckingIfUserAlreadyExists ||
                                    state is AuthUserAlreadyExists)
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<AuthCubit>(context)
                                          .checkIfUserAlreadyExists(
                                        _emailController.text.trim(),
                                      );
                                    }
                                  },
                            child: (state is AuthSendingPasswordResetEmail ||
                                    state is AuthCheckingIfUserAlreadyExists ||
                                    state is AuthUserAlreadyExists)
                                ? const CustomCircularProgressIndicator()
                                : const Text('Send Reset Link'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 100.h),

            // Remember password?
            AuthScreensBottomRow(
              label1: "Remember password? ",
              label2: "Login",
              onTap: () => NavigationService.goBack(),
            ),
          ],
        ),
      ),
    );
  }
}
