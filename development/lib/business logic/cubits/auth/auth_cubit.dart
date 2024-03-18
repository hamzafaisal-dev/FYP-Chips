import 'package:bloc/bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  //
  void authStateUpdatedEvent(UserModel updatedUser) {
    try {
      print(updatedUser.favoritedChips);
      emit(AuthUserSignedIn(user: updatedUser));
    } catch (e) {
      print(e.toString());
    }
  }

  // check if user already signed in
  Future<void> checkIfUserAlreadySignedIn() async {
    emit(AuthCheckingIfUserAlreadySignedIn());
    try {
      User? user = _authRepository.checkIfUserAlreadySignedIn();
      if (user == null) {
        emit(AuthUserNotAlreadySignedIn());
        emit(AuthInitial());
      } else {
        UserModel userModel = await _authRepository.getCurrentUser(user);
        emit(AuthUserAlreadySignedIn(user: userModel));
        emit(AuthUserSignedIn(user: userModel));
      }
    } catch (error) {
      emit(AuthFailedCheckingIfUserAlreadySignedIn(message: error.toString()));
    }
  }

  // email password sign in
  Future<void> emailPasswordSignIn(String email, String password) async {
    emit(AuthSignInLoading());
    try {
      UserModel user =
          await _authRepository.emailPasswordSignIn(email, password);
      emit(AuthSignInSuccess(user: user));
      emit(AuthUserSignedIn(user: user));
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
  Future<void> sendOtpEmail(String email, String name) async {
    emit(AuthOtpEmailSending());
    try {
      Map<String, dynamic> response =
          await _authRepository.sendOtpEmail(email, name);
      emit(AuthOtpEmailSent(
        email: email,
        otp: response['otp'],
      ));
    } catch (error) {
      emit(AuthOtpEmailFailedToSend(message: error.toString()));
    }
  }

  // check if user exists
  Future<void> checkIfUserAlreadyExists(String email) async {
    emit(AuthCheckingIfUserAlreadyExists());
    try {
      bool exists = await _authRepository.checkIfUserExists(email);
      if (exists) {
        emit(AuthUserAlreadyExists());
        emit(AuthInitial());
      } else {
        emit(AuthUserDoesNotExist());
        emit(AuthInitial());
      }
    } catch (error) {
      emit(AuthFailureCheckingUserExistance(message: error.toString()));
    }
  }

  // verify otp
  Future<void> verifyOtp(String userInput, String otp) async {
    if (_authRepository.verifyOtp(userInput, otp)) {
      emit(AuthOtpVerified());
    } else {
      emit(AuthOtpNotVerified());
    }
  }

  // send onboarding email
  Future<void> sendOnboardingEmail(UserModel userModel) async {
    try {
      await _authRepository.sendOnboardingEmail(
          userModel.email, userModel.name);
    } catch (error) {
      emit(AuthOtpEmailFailedToSend(message: error.toString()));
    }
  }

  // email password sign up
  Future<void> emailPasswordSignUp(
      String name, String email, String password) async {
    emit(AuthSignUpLoading());
    try {
      UserModel user =
          await _authRepository.emailPasswordSignUp(name, email, password);
      emit(AuthSignUpSuccess(user: user));
      emit(AuthUserSignedIn(user: user));
    } catch (error) {
      emit(AuthSignUpFailure(message: error.toString()));
      emit(AuthInitial());
    }
  }

  // send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      emit(AuthSendingPasswordResetEmail());
      await _authRepository.sendPasswordResetEmail(email);
      emit(AuthPasswordResetEmailSent());
    } catch (error) {
      emit(AuthPasswordResetEmailFailedToSend(message: error.toString()));
    }
  }
}
