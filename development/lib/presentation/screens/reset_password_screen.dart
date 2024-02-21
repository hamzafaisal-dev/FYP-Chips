import 'package:development/constants/styles.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        forceMaterialTransparency: true,
        leading: const BackButton(
          color: Color(0XFF573353),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 24.h),
          children: [
            // FORGOT YOUR PASSWORD?
            Text(
              'FORGOT YOUR PASSWORD?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 39.h),

            // Image
            Image.asset('assets/images/forgot_password.png'),

            SizedBox(height: 45.h),

            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: const Color(0XFFFFFFFF),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                child: Column(
                  children: [
                    // Enter your registered...
                    Text(
                      'Enter your registered email below to receive password reset instruction',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    SizedBox(height: 30.h),

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
                      validator: (value) =>
                          FormValidators.emailValidator(value),
                    ),

                    SizedBox(height: 10.h),

                    // Send Reset Link button
                    SizedBox(
                      width: double.maxFinite,
                      child: FilledButton(
                        onPressed: () {},
                        style: Theme.of(context).filledButtonTheme.style,
                        child: Text(
                          'Send Reset Link',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 100.h),

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
