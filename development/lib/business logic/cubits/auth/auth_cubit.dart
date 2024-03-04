import 'package:bloc/bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  // email password sign in
  Future<void> emailPasswordSignIn(String email, String password) async {
    emit(AuthSignInLoading());
    try {
      UserModel user =
          await _authRepository.emailPasswordSignIn(email, password);
      emit(AuthSignInSuccess(user: user));
    } catch (error) {
      emit(AuthSignInFailure(message: error.toString()));
    }
  }

  // sign out
  Future<void> signOut() async {
    _authRepository.signOut();
    emit(AuthInitial());
  }

  // send otp email
  Future<void> sendOtpEmail(String email, String name, String password) async {
    emit(AuthOtpEmailSending());
    try {
      Map<String, dynamic> response =
          await _authRepository.sendOtpEmail(email, name, password);
      emit(AuthOtpEmailSent(
        email: email,
        otp: response['otp'],
        name: response['name'],
        password: response['password'],
      ));
    } catch (error) {
      emit(AuthOtpEmailFailedToSend(message: error.toString()));
    }
  }

  // verify otp
  Future<void> verifyOtp(String userInput, String otp, String email,
      String name, String password) async {
    if (_authRepository.verifyOtp(userInput, otp)) {
      emit(AuthOtpVerified(email: email, name: name, password: password));
    } else {
      emit(AuthOtpNotVerified(email: email, name: name, password: password));
    }
  }

  // send onboarding email
  Future<void> sendOnboardingEmail(UserModel userModel) async {
    try {
      await _authRepository.sendOnboardingEmail(
          userModel.email, userModel.name);
    } catch (error) {}
  }

  // email password sign up
  Future<void> emailPasswordSignUp(
      String name, String email, String password) async {
    emit(AuthSignUpLoading());
    try {
      UserModel user =
          await _authRepository.emailPasswordSignUp(name, email, password);
      emit(AuthSignUpSuccess(user: user, password: password));
    } catch (error) {
      emit(AuthSignUpFailure(message: error.toString()));
      emit(AuthInitial());
    }
  }
}
