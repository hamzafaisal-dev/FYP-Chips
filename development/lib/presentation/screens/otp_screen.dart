import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/presentation/themes/custom_themes/pinput_theme.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    this.arguments,
  });

  final Map<String, dynamic>? arguments;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String _userEmail;
  late String _userPassword;
  late String _userName;
  late String _otp;

  @override
  void initState() {
    if (widget.arguments != null) {
      _userEmail = widget.arguments!["email"].toString().toLowerCase();
      _userPassword = widget.arguments!["password"];
      _userName = widget.arguments!["name"];
      _otp = widget.arguments!["otp"];
    }

    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthOtpVerified) {
              BlocProvider.of<AuthCubit>(context).emailPasswordSignUp(
                _userName,
                _userEmail,
                _userPassword,
              );
            }
            if (state is AuthOtpNotVerified) {
              HelperWidgets.showSnackbar(
                context,
                'Invalid OTP! Please try again!',
                'error',
              );
            }
            if (state is AuthSignUpLoading) {
              HelperWidgets.showSnackbar(
                context,
                'OTP Verified Successfully! Creating your account...',
                'info',
              );
            }
            if (state is AuthSignUpSuccess) {
              HelperWidgets.showSnackbar(
                context,
                'Account Created Successfully! Welcome to Chips!🍟',
                'success',
              );
              BlocProvider.of<AuthCubit>(context)
                  .sendOnboardingEmail(state.user);
            }
            if (state is AuthSignUpFailure) {
              HelperWidgets.showSnackbar(
                context,
                'Failed to create account: ${state.message}',
                'error',
              );
            }
            if (state is AuthUserSignedIn) {
              NavigationService.pushAndRemoveUntil('/layout');
            }
          },
          buildWhen: (previous, current) {
            return previous != current;
          },
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // art
                      SvgPicture.asset(
                        AssetPaths.otpScreenBannerPath,
                        height: 279.h,
                      ),

                      SizedBox(height: 36.9.h),

                      // otp verification
                      Text(
                        "OTP Verification",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),

                      SizedBox(height: 18.h),

                      // instructive text
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 36.w),
                        child: const Text(
                          "Please enter the OTP we have sent to you on this email address:",
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 6.3.h),

                      // email
                      Text(
                        _userEmail,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 23.4.h),

                      // otp input field
                      Pinput(
                        length: 6,
                        defaultPinTheme: PinputTheme.pinTheme,
                        hapticFeedbackType: HapticFeedbackType.heavyImpact,
                        controller: _otpController,
                        key: _formKey,
                        validator: (value) =>
                            FormValidators.otpValidator(value),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        onCompleted: (value) {
                          BlocProvider.of<AuthCubit>(context).verifyOtp(
                            _otpController.text,
                            _otp,
                          );
                        },
                      ),

                      SizedBox(height: 81.h),

                      // resend code
                      // state is AuthOtpEmailFailedToSend ||
                      //         state is AuthOtpNotVerified
                      //     ? Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text(
                      //             state is AuthOtpEmailFailedToSend
                      //                 ? 'Didn\'t receive OTP? '
                      //                 : 'Invalid OTP! ',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .bodyMedium
                      //                 ?.copyWith(
                      //                   fontWeight: FontWeight.w400,
                      //                 ),
                      //           ),
                      //           InkWell(
                      //             onTap: () {
                      //               BlocProvider.of<AuthCubit>(context).sendOtpEmail(
                      //                     _userEmail,
                      //                     _userName,
                      //                   );
                      //             },
                      //             child: Text(
                      //               'Resend Code',
                      //               style: Theme.of(context)
                      //                   .textTheme
                      //                   .bodyMedium
                      //                   ?.copyWith(
                      //                     fontWeight: FontWeight.w700,
                      //                   ),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
