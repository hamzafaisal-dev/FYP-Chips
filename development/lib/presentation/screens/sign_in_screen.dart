import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  void _handleLogin() {
    // // handle login code
    // print(_emailController.text);
    // print(_passwordController.text);

    // BlocProvider.of<SignInBloc>(context).add(
    //   SignInSubmittedEvent(
    //     _emailController.text,
    //     _passwordController.text,
    //   ),
    // );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginFormKey,
          child: ListView(
            padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
            children: [
              SizedBox(height: 302.h),

              // welcome
              Text(
                'Welcome To Chips',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              // quote
              Text(
                'A one stop shop for internChips and job sauce',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              SizedBox(height: 25.h),

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
              ),

              SizedBox(height: 21.h),

              //login button
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  print(state);
                  if (state is AuthLoading) {
                    print('sign in loading');
                  } else if (state is AuthSuccess) {
                    print(state.user);

                    NavigationService.routeToReplacementNamed('/layout');
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    onPressed: (state is AuthLoading)
                        ? null
                        : () {
                            if (_loginFormKey.currentState!.validate()) {
                              _handleLogin();
                            }
                          },
                    child: (state is AuthLoading)
                        ? SizedBox(
                            width: 23.4.w,
                            height: 23.4.h,
                            child: const CircularProgressIndicator(),
                          )
                        : const Text('Login'),
                  );
                },
              ),

              SizedBox(height: 13.h),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () =>
                        NavigationService.routeToNamed("/reset-password"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  InkWell(
                    onTap: () => NavigationService.routeToNamed("/signup"),
                    child: Text(
                      'Sign Up',
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
