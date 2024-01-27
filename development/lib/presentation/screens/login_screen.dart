import 'package:development/constants/styles.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              //
              TextFormField(
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter your IBA email address',
                  const Icon(Icons.email),
                  null,
                  context,
                ),
              ),

              const SizedBox(height: 20),

              TextFormField(
                decoration: TextFormFieldStyles.textFormFieldDecoration(
                  'Enter password',
                  const Icon(Icons.email),
                  null,
                  context,
                ),
              ),

              const SizedBox(height: 20),

              //login button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                  onPressed: () {
                    // if (_loginFormKey.currentState!.validate()) {
                    //   _handleSignInPressed();
                    // }
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
