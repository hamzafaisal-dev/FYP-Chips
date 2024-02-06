import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              //
              // SizedBox(height: MediaQuery.of(context).size.height / 4.5),

              // Image
              Image.asset(
                'assets/Chips - Create Your Account.png',
              ),

              // Create Your Account
              const Text(
                'CREATE YOUR ACCOUNT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // name form field
              TextFormField(
                controller: _nameController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter name',
                  const Icon(Icons.person),
                  null,
                  context,
                ),
                validator: (value) => FormValidators.nameValidator(value),
              ),

              const SizedBox(height: 20),

              // email form field
              TextFormField(
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

              const SizedBox(height: 20),

              // password form field
              TextFormField(
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
                ),
                validator: (value) => FormValidators.passwordValidator(value),
              ),

              const SizedBox(height: 20),

              //sign up button
              BlocConsumer<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpLoadingState) {
                    print('sign up loading');
                  } else if (state is SignUpValidState) {
                    print(state.newUser);

                    NavigationService.routeToNamed('/profile');
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
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Create Account',
                              // style: TextStyle(fontSize: 16),
                            ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),

              // Already have an account?
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/login'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
