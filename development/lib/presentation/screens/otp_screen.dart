import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/styles.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthOtpVerified) {
              print(
                  "signing up ${state.email} called ${state.name} with password ${state.password}");
              context.read<AuthCubit>().emailPasswordSignUp(
                    state.name.toString(),
                    state.email.toString(),
                    state.password.toString(),
                  );
            }
            if (state is AuthOtpNotVerified) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Invalid OTP'),
                ),
              );
            }

            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Signed up successfully'),
                ),
              );
              NavigationService.routeToReplacementNamed('/home');
            }

            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox.shrink(
                      child: Text(
                        state is AuthOtpEmailSent
                            ? 'OTP sent to ${state.email}'
                            : '',
                      ),
                    ),
                    SizedBox.shrink(
                      child: Text(
                        state is AuthOtpEmailSent
                            ? 'OTP sent to ${state.name}'
                            : '',
                      ),
                    ),
                    SizedBox.shrink(
                      child: Text(
                        state is AuthOtpEmailSent
                            ? 'Password ${state.password}'
                            : '',
                      ),
                    ),
                    SizedBox.shrink(
                      child: Text(
                        state is AuthOtpEmailSent ? 'OTP: ${state.email}' : '',
                      ),
                    ),
                  ],
                ),
                // otp field
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _otpController,
                    decoration: TextFormFieldStyles.textFormFieldDecoration(
                      'otp code',
                      const Icon(Icons.security_update_good_outlined),
                      null,
                      context,
                      null,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => FormValidators.otpValidator(value),
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),

                // verify otp button
                TextButton(
                  onPressed: () {
                    if (!_set) {
                      _otp = (state as AuthOtpEmailSent).otp;
                      _email = (state).email;
                      _name = (state).name;
                      _password = (state).password;
                      _set = true;
                    }
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().verifyOtp(
                            _otpController.text,
                            _otp,
                            _email,
                            _name,
                            _password,
                          );
                    }
                  },
                  child: const Text('Verify OTP'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
