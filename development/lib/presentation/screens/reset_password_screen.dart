import 'package:development/constants/styles.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFFF3E9),
      appBar: AppBar(
        // backgroundColor: const Color(0XFFFFF3E9),
        backgroundColor: Colors.transparent,
        elevation: 0,
        forceMaterialTransparency: true,
        foregroundColor: const Color(0XFF573353),
        leading: const BackButton(
          color: Color(0XFF573353),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // FORGOT YOUR PASSWORD?
            Text(
              'FORGOT YOUR PASSWORD?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 39),

            // Image
            Image.asset('assets/images/forgot_password.png'),

            const SizedBox(height: 45),

            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                color: const Color(0XFFFFFFFF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // Enter your registered...
                  Text(
                    'Enter your registered email below to receive password reset instruction',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 30),

                  // Email text field
                  TextFormField(
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    // controller: _emailController,
                    decoration: TextFormFieldStyles.textFormFieldDecoration(
                      'j.doe.36963@khi.iba.edu.pk',
                      null,
                      null,
                      context,
                    ).copyWith(
                      fillColor: const Color(0XFFFFF6ED),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => FormValidators.emailValidator(value),
                  ),

                  const SizedBox(height: 10),

                  // Send Reset Link button
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FilledButton(
                      onPressed: () {},
                      style: Theme.of(context).filledButtonTheme.style,
                      child: Text(
                        'Send Reset Link',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),

            // Remember password?
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Remember password? ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: Text(
                    'Login',
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
    );
  }
}
