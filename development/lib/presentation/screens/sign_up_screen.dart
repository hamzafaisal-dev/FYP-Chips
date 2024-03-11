import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              Image.asset(
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
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Full Name',
                  const Icon(Icons.person_outline),
                  null,
                  context,
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
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'IBA Email',
                  const Icon(Icons.email_outlined),
                  null,
                  context,
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
                decoration: TextFormFieldStyles.textFormFieldDecoration(
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
                decoration: TextFormFieldStyles.textFormFieldDecoration(
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

              //sign up button
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
                    context.read<AuthCubit>().sendOtpEmail(
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
                      "Sending OTP to your email...",
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
                    print("otp sent to: ${state.email}");
                    print("otp: ${state.otp}");
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return OtpSentDialog(email: state.email);
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
                                      _emailController.text);
                            }
                          },
                    child: (state is AuthOtpEmailSending ||
                            state is AuthCheckingIfUserAlreadyExists ||
                            state is AuthUserDoesNotExist)
                        ? SizedBox(
                            height: 23.4.h,
                            width: 23.4.w,
                            child: const CircularProgressIndicator(),
                          )
                        : const Text('Create Account'),
                  );
                },
              ),

              SizedBox(height: 108.h),

              // Already have an account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  InkWell(
                    onTap: () => NavigationService.goBack(),
                    child: Text(
                      "Sign In",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
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

class OtpSentDialog extends StatelessWidget {
  const OtpSentDialog({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'OTP Sent',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'An OTP has been sent to:\n\n',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text: email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            TextSpan(
              text:
                  '\n\nPlease proceed to verify your email and complete your sign up.\n\n',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            TextSpan(
              text:
                  'Note: Please check your email inbox, including your spam/junk folder, for the OTP. If you cannot find the email, please ensure you entered the correct email address and try again.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.63),
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            NavigationService.routeToReplacementNamed(
              '/otp',
            );
          },
          child: Text(
            'Proceed',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
