import 'package:development/constants/styles.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _signUpFormKey = GlobalKey<FormState>();

  void _handleSignUp() {
    // handle login code

    print(_emailController.text);
    print(_passwordController.text);
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
          key: _signUpFormKey,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              //
              SizedBox(height: MediaQuery.of(context).size.height / 4.5),

              // Get On Board!
              const Text(
                'Get On Board!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              // Create your profile...
              const Text(
                'Create your profile to start your journey',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
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

              //signup button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () {
                    if (_signUpFormKey.currentState!.validate()) {
                      _handleSignUp();
                    }
                  },
                  style: Theme.of(context).filledButtonTheme.style,
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w900),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/login');
                        },
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
