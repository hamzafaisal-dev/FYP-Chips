import 'package:development/constants/styles.dart';
import 'package:development/presentation/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

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
              CustomTextFormField(
                label: 'Enter your IBA email address',
                prefixIcon: const Icon(Icons.email),
                validatorFunction: (value) {
                  if (value == '') {
                    return 'Khaali hai';
                  }

                  return null;
                },
              ),

              // const SizedBox(height: 20),

              // TextFormField(
              //   controller: _emailController,
              //   decoration: TextFormFieldStyles.textFormFieldDecoration(
              //     'Enter your IBA email address',
              //     const Icon(Icons.email),
              //     null,
              //     context,
              //   ),
              //   keyboardType: TextInputType.emailAddress,
              //   validator: (value) {
              //     if (value == '') {
              //       return 'Khaali hai';
              //     }

              //     return null;
              //   },
              // ),

              const SizedBox(height: 20),

              // password form field
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordVisible,
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter password',
                  const Icon(Icons.lock_outline),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: _isPasswordVisible
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                  context,
                ),
                keyboardType: TextInputType.visiblePassword,
              ),

              const SizedBox(height: 20),

              //login button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      // _handleSignInPressed();

                      print(_emailController.text);
                      print(_passwordController.text);
                    }
                  },
                  style: Theme.of(context).filledButtonTheme.style,
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
