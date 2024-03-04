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
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _set = false;
  late String _otp;
  late String _email;
  late String _name;
  late String _password;

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
            if (state is AuthOtpEmailSending) {
              HelperWidgets.showSnackbar(
                context,
                'Sending OTP, please hold on...',
                'info',
              );
            }
            if (state is AuthOtpEmailSent) {
              HelperWidgets.showSnackbar(
                context,
                'OTP sent to ${state.email}',
                'info',
              );
            }
            if (state is AuthOtpEmailFailedToSend) {
              HelperWidgets.showSnackbar(
                context,
                'Failed to send OTP: ${state.message}',
                'error',
              );
            }
            if (state is AuthOtpVerified) {
              HelperWidgets.showSnackbar(
                context,
                'OTP Verified Successfully!',
                'success',
              );
              context.read<AuthCubit>().emailPasswordSignUp(
                    state.name.toString(),
                    state.email.toString(),
                    state.password.toString(),
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
                'Creating your account, please hold on...',
                'info',
              );
            }
            if (state is AuthSignUpSuccess) {
              HelperWidgets.showSnackbar(
                context,
                'Account Created Successfully! Welcome to Chips!🍟',
                'success',
              );
              context.read<AuthCubit>().sendOnboardingEmail(state.user);
            }
            if (state is AuthSignUpFailure) {
              HelperWidgets.showSnackbar(
                context,
                'Failed to create account: ${state.message}',
                'error',
              );
            }
            if (state is AuthSignInSuccess) {
              HelperWidgets.showSnackbar(
                context,
                'Signed in Successfully!',
                'success',
              );
              NavigationService.routeToReplacementNamed('/layout');
            }
            if (state is AuthSignInLoading) {
              HelperWidgets.showSnackbar(
                context,
                'Signing you in, please hold on...',
                'info',
              );
            }
            if (state is AuthSignInSuccess) {
              HelperWidgets.showSnackbar(
                context,
                'Signed in Successfully!',
                'success',
              );
              NavigationService.routeToReplacementNamed('/layout');
            }
            if (state is AuthSignInFailure) {
              HelperWidgets.showSnackbar(
                context,
                'Failed to sign in: ${state.message}',
                'error',
              );
            }
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
                        state is AuthOtpEmailSent
                            ? state.email
                            : state is AuthOtpVerified
                                ? state.email
                                : state is AuthOtpNotVerified
                                    ? state.email
                                    : state is AuthSignInSuccess
                                        ? state.user.email
                                        : state is AuthSignUpSuccess
                                            ? state.user.email
                                            : _email,
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
                          HelperWidgets.showSnackbar(
                            context,
                            'Verifying OTP, please hold on...',
                            'info',
                          );
                          if (!_set) {
                            setState(() {
                              _otp = (state as AuthOtpEmailSent).otp;
                              _email = (state).email;
                              _name = (state).name;
                              _password = (state).password;
                              _set = true;
                            });
                          }
                          context.read<AuthCubit>().verifyOtp(
                                _otpController.text,
                                _otp,
                                _email,
                                _name,
                                _password,
                              );
                        },
                      ),

                      SizedBox(height: 81.h),

                      // resend code
                      SizedBox.shrink(
                        child: state is AuthOtpEmailFailedToSend
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Didn\'t receive OTP? ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _set = false;
                                      });
                                      context.read<AuthCubit>().sendOtpEmail(
                                          _email, _name, _password);
                                    },
                                    child: Text(
                                      'Resend Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                ],
                              )
                            : state is AuthOtpNotVerified
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        _set = false;
                                      });
                                      context.read<AuthCubit>().sendOtpEmail(
                                          _email, _name, _password);
                                    },
                                    child: Text(
                                      'Resend Code',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  )
                                : null,
                      ),
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
