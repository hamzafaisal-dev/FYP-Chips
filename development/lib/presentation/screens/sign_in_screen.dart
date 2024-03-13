import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/auth_screens_bottom_row.dart';
import '../widgets/custom_circular_progress_indicator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginFormKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _loginFormKey,
          child: ListView(
            children: [
              SizedBox(height: 81.h),

              // banner
              SvgPicture.asset(
                AssetPaths.signInScreenBannerPath,
                width: 374.w,
              ),

              // welcome
              Text(
                'Welcome to Chips!🍟',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),

              // quote
              Text(
                "IBA's one stop shop for internChips and job sauce.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 23.4.h),

              // email form field
              TextFormField(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: _emailController,
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter IBA email address',
                  const Icon(Icons.email_outlined),
                  null,
                  context,
                  null,
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => FormValidators.emailValidator(value),
              ),

              SizedBox(height: 8.h),

              // password form field
              TextFormField(
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter password',
                  const Icon(Icons.lock_outline),
                  IconButton(
                    onPressed: () {
                      setState(
                        () => _isPasswordVisible = !_isPasswordVisible,
                      );
                    },
                    icon: _isPasswordVisible
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                  context,
                  null,
                ),
                validator: (value) => FormValidators.passwordValidator(value),
              ),

              SizedBox(height: 21.h),

              //login button
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSignInSuccess) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Signed in successfully! Welcome back!🎉",
                      "success",
                    );
                    NavigationService.routeToReplacementNamed("/layout");
                  }
                  if (state is AuthSignInFailure) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Failed to sign in: ${state.message}",
                      "error",
                    );
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    onPressed: (state is AuthSignInLoading)
                        ? null
                        : () {
                            if (_loginFormKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context)
                                  .emailPasswordSignIn(
                                _emailController.text,
                                _passwordController.text,
                              );
                            }
                          },
                    child: (state is AuthSignInLoading)
                        ? const CustomCircularProgressIndicator()
                        : const Text('Login'),
                  );
                },
              ),

              SizedBox(height: 18.h),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () =>
                        NavigationService.routeToNamed('/reset-password'),
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 6.h),

              // don't have an account? sign up
              AuthScreensBottomRow(
                label1: "Don't have an account? ",
                label2: "Sign Up",
                onTap: () => NavigationService.routeToNamed("/signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
