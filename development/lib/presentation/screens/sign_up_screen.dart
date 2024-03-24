import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/presentation/widgets/auth_screens_bottom_row.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/otp_sent_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _signUpFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _signUpFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              SizedBox(height: 36.h),

              // Image
              SvgPicture.asset(
                AssetPaths.signUpScreenBannerPath,
                height: 200.h,
                width: 187.76.w,
              ),

              SizedBox(height: 21.h),

              // Create Your Account
              Text(
                'CREATE YOUR ACCOUNT',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 32.h),

              // name form field
              TextFormField(
                controller: _nameController,
                decoration: Styles.textFormFieldDecoration(
                  'Your Display Name',
                  const Icon(Icons.person_outline),
                  null,
                  context,
                  null,
                  null,
                ),
                validator: (value) => FormValidators.nameValidator(value),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),

              SizedBox(height: 8.h),

              // email form field
              TextFormField(
                controller: _emailController,
                decoration: Styles.textFormFieldDecoration(
                  'IBA Email',
                  const Icon(Icons.email_outlined),
                  null,
                  context,
                  null,
                  null,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => FormValidators.emailValidator(value),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),

              SizedBox(height: 8.h),

              // password form field
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: Styles.textFormFieldDecoration(
                  'Password',
                  const Icon(Icons.lock_outline),
                  IconButton(
                    onPressed: () {
                      setState(() => _isPasswordVisible = !_isPasswordVisible);
                    },
                    icon: _isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  context,
                  null,
                  null,
                ),
                validator: (value) => FormValidators.passwordValidator(value),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
              ),

              SizedBox(height: 8.h),

              // confirm password form field
              TextFormField(
                obscureText: !_isConfirmPasswordVisible,
                decoration: Styles.textFormFieldDecoration(
                  'Confirm Password',
                  const Icon(Icons.lock_outline),
                  IconButton(
                    onPressed: () {
                      setState(() => _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible);
                    },
                    icon: _isConfirmPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  context,
                  null,
                  null,
                ),
                validator: (value) => FormValidators.confirmPasswordValidator(
                  value,
                  _passwordController.text,
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: _confirmPasswordController,
              ),

              SizedBox(height: 28.h),

              // create account button
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthUserAlreadyExists) {
                    HelperWidgets.showSnackbar(
                      context,
                      "An account with this email already exists. Please sign in instead.",
                      'error',
                    );
                  }
                  if (state is AuthUserDoesNotExist) {
                    BlocProvider.of<AuthCubit>(context).sendOtpEmail(
                      _emailController.text,
                      _nameController.text,
                    );
                  }
                  if (state is AuthFailureCheckingUserExistance) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Failed to check if user exists: ${state.message} Please try again.",
                      'error',
                    );
                  }
                  if (state is AuthOtpEmailSending) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Sending OTP to your email, thank you for your patience!😄",
                      'info',
                    );
                  }
                  if (state is AuthOtpEmailFailedToSend) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Failed to send OTP to your email: ${state.message} Please try again.",
                      'error',
                    );
                  }
                  if (state is AuthOtpEmailSent) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return OtpSentDialog(
                          email: state.email,
                          onProceed: () {
                            Navigator.pop(context);
                            NavigationService.routeToNamed(
                              '/otp',
                              arguments: {
                                "email": state.email,
                                "otp": state.otp,
                                "name": _nameController.text,
                                "password": _passwordController.text,
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    onPressed: (state is AuthOtpEmailSending ||
                            state is AuthCheckingIfUserAlreadyExists ||
                            state is AuthUserDoesNotExist)
                        ? null
                        : () {
                            if (_signUpFormKey.currentState!.validate()) {
                              context
                                  .read<AuthCubit>()
                                  .checkIfUserAlreadyExists(
                                    _emailController.text,
                                  );
                            }
                          },
                    child: (state is AuthOtpEmailSending ||
                            state is AuthCheckingIfUserAlreadyExists ||
                            state is AuthUserDoesNotExist)
                        ? const CustomCircularProgressIndicator()
                        : const Text('Create Account'),
                  );
                },
              ),

              SizedBox(height: 108.h),

              // Already have an account?
              AuthScreensBottomRow(
                label1: "Already have an account? ",
                label2: "Sign In",
                onTap: () => NavigationService.goBack(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
