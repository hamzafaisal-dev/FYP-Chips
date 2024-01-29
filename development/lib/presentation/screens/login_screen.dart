import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:development/constants/validators.dart';

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
            padding: const EdgeInsets.all(24),
            children: [
              //

              // email form field
              TextFormField(
                controller: _emailController,
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter your IBA email address',
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

              //login button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      _handleLogin();
                    }
                  },
                  style: Theme.of(context).filledButtonTheme.style,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // buttons
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/signup');
                            },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => NavigationService.routeToNamed("/resetpass"),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
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
