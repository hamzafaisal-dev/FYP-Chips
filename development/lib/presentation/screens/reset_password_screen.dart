import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFF3E9),
      appBar: AppBar(
        backgroundColor: const Color(0XFFFFF3E9),
        leading: const BackButton(
          color: Color(0XFF573353),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            //
            // SizedBox(height: MediaQuery.of(context).size.height / 4.5),

            // FORGOT YOUR PASSWORD?
            const Text(
              'FORGOT YOUR PASSWORD?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0XFF573353),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 39),

            // Image
            Image.asset(
              'assets/images/Chips - Forgot Password Image.png',
            ),

            const SizedBox(height: 40),

            Container(
              width: MediaQuery.of(context).size.width,
              // height: 380,
              padding: const EdgeInsets.fromLTRB(20, 20, 28, 20),
              decoration: BoxDecoration(
                color: const Color(0XFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Enter your registered...
                  const Text(
                    'Enter your registered email below to receive password reset instruction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0XFF573353),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Email text field
                  TextField(
                    //
                    style: const TextStyle(
                      color: Color(0XFFFDA758),
                      fontWeight: FontWeight.w700,
                      // fontSize: 18,
                    ),

                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      //
                      filled: true,

                      fillColor: const Color(0XFFFFF6ED),

                      hintText: 'j.doe.69420@khi.iba.edu.pk',

                      hintStyle: const TextStyle(color: Color(0XFFAA98A8)),

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          color: Color(0XFFFFF6ED),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          color: Color(0XFFFFF6ED),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      floatingLabelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),

                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Send Reset Link button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0XFFFDA758),
                      ),
                      child: FilledButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0XFFFDA758),
                          ),
                        ),
                        child: const Text(
                          'Send Reset Link',
                          style: TextStyle(
                            color: Color(0XFF573353),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Remember password?
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Remember password? ',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0XFF573353),
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
          ],
        ),
      ),
    );
  }
}
