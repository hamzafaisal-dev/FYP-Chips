import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
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

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  void _handleSignUp() {
    BlocProvider.of<SignUpBloc>(context).add(
      SignUpSubmittedEvent(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _signUpFormKey,
          child: RPadding(
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: [
                const RSizedBox.vertical(24),

                // Image
                Image.asset(
                  height: 200.h,
                  width: 187.76.w,
                  'assets/images/create_account.png',
                ),

                const RSizedBox.vertical(21),

                // Create Your Account
                Text(
                  'CREATE YOUR ACCOUNT',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),

                const RSizedBox.vertical(32),

                // name form field
                TextFormField(
                  controller: _nameController,
                  decoration: TextFormFieldStyles.textFormFieldDecoration(
                    'Full Name',
                    const Icon(Icons.person_outline),
                    null,
                    context,
                  ),
                  validator: (value) => FormValidators.nameValidator(value),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),

                const RSizedBox.vertical(8),

                // email form field
                TextFormField(
                  controller: _emailController,
                  decoration: TextFormFieldStyles.textFormFieldDecoration(
                    'IBA Email',
                    const Icon(Icons.email_outlined),
                    null,
                    context,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => FormValidators.emailValidator(value),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),

                const RSizedBox.vertical(8),

                // password form field
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: TextFormFieldStyles.textFormFieldDecoration(
                    'Password',
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
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),

                const RSizedBox.vertical(28),

                //sign up button
                BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SignUpLoadingState) {
                      print('sign up loading');
                    } else if (state is SignUpValidState) {
                      print(state.newUser);

                      NavigationService.routeToReplacementNamed('/layout');
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FilledButton(
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            _handleSignUp();
                          }
                        },
                        style: Theme.of(context).filledButtonTheme.style,
                        child: (state is SignUpLoadingState)
                            ? const SizedBox(
                                height: 22,
                                width: 22,
                                child: CircularProgressIndicator(),
                              )
                            : const Text(
                                'Create Account',
                              ),
                      ),
                    );
                  },
                ),

                const RSizedBox.vertical(144),

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
      ),
    );
  }
}
