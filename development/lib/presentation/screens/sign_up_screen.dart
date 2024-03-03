import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
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
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
            children: [
              SizedBox(height: 24.h),

              // Image
              Image.asset(
                AssetPaths.signupScreenBannerPath,
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
                  if (state is AuthLoading) {
                    print('sign up loading');
                  } else if (state is AuthSuccess) {
                    print(state.user);
                  }
                  if (state is AuthOtpEmailSent) {
                    print("otp sent to: ${state.email}");
                    print("otp: ${state.otp}");
                    print("name: ${state.name}");
                    print("password: ${state.password}");
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
                    onPressed: (state is AuthLoading)
                        ? null
                        : () {
                            if (_signUpFormKey.currentState!.validate()) {
                              context.read<AuthCubit>().sendOtpEmail(
                                  _emailController.text,
                                  _nameController.text,
                                  _passwordController.text);
                            }
                          },
                    child: (state is AuthLoading)
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
                    onTap: () => Navigator.pushNamed(context, '/login'),
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
