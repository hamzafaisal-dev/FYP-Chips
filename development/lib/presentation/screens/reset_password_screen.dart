import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/styles.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
          children: [
            // back button
            Align(
              alignment: Alignment.centerLeft,
              child: CustomIconButton(
                iconSvgPath: AssetPaths.leftArrowIconPath,
                iconWidth: 16.5.w,
                iconHeight: 12.h,
                onTap: () => Navigator.pop(context),
              ),
            ),

            SizedBox(height: 25.h),

            // FORGOT YOUR PASSWORD?
            Text(
              'FORGOT YOUR PASSWORD?',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 39.h),

            // Image
            Image.asset(
              AssetPaths.resetPasswordScreenBannerPath,
              width: double.maxFinite,
              height: 264.h,
            ),

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
                        null,
                      ).copyWith(
                        fillColor: const Color(0XFFFFF6ED),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          FormValidators.emailValidator(value),
                    ),

                    SizedBox(height: 10.h),

                    // Send Reset Link button
                    FilledButton(
                      onPressed: () {},
                      child: const Text('Send Reset Link'),
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
