import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

  void _handleLogin() {
    // handle login code
    print(_emailController.text);
    print(_passwordController.text);

    BlocProvider.of<SignInBloc>(context).add(
      SignInSubmittedEvent(
        _emailController.text,
        _passwordController.text,
      ),
    );
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
          child: RPadding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              // padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
              children: [
                // SizedBox(height: 302.h),
                const RSizedBox.vertical(302),

                // welcome back
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),

                // quote
                Text(
                  'goofy ahh quote - nami, probably',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const RSizedBox.vertical(25),

                // email form field
                TextFormField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  controller: _emailController,
                  decoration: TextFormFieldStyles.textFormFieldDecoration(
                    'Enter IBA email address',
                    const Icon(Icons.email),
                    null,
                    context,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => FormValidators.emailValidator(value),
                ),

                const RSizedBox.vertical(8),

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
                            () => _isPasswordVisible = !_isPasswordVisible);
                      },
                      icon: _isPasswordVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                    context,
                  ),
                  validator: (value) => FormValidators.passwordValidator(value),
                ),

                const RSizedBox.vertical(21),

                //login button
                BlocConsumer<SignInBloc, SignInState>(
                  listener: (context, state) {
                    print(state);
                    if (state is SignInLoadingState) {
                      print('sign in loading');
                    } else if (state is SignInValidState) {
                      // print(state.authenticatedUser);

                      NavigationService.routeToReplacementNamed('/layout');
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            _handleLogin();
                          }
                        },
                        style: Theme.of(context).filledButtonTheme.style,
                        child: (state is SignInLoadingState)
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Login'),
                      ),
                    );
                  },
                ),

                const RSizedBox.vertical(13),

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

                const RSizedBox.vertical(6),

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
      ),
    );
  }
}
