part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthUserSignedIn extends AuthState {
  final UserModel user;

  const AuthUserSignedIn({required this.user});

  @override
  List<Object> get props => [user];
}

// user state change
final class AuthCheckingIfUserAlreadySignedIn extends AuthState {}

final class AuthFailedCheckingIfUserAlreadySignedIn extends AuthState {
  final String message;

  const AuthFailedCheckingIfUserAlreadySignedIn({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthUserAlreadySignedIn extends AuthState {
  final UserModel user;

  const AuthUserAlreadySignedIn({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthUserNotAlreadySignedIn extends AuthState {}

// email password sign in
final class AuthSignInLoading extends AuthState {}

final class AuthSignInSuccess extends AuthState {
  final UserModel user;

  const AuthSignInSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthSignInFailure extends AuthState {
  final String message;

  const AuthSignInFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// email password sign up
final class AuthCheckingIfUserAlreadyExists extends AuthState {}

final class AuthFailureCheckingUserExistance extends AuthState {
  final String message;

  const AuthFailureCheckingUserExistance({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthUserAlreadyExists extends AuthState {}

final class AuthUserDoesNotExist extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final UserModel user;

  const AuthSignUpSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthSignUpFailure extends AuthState {
  final String message;

  const AuthSignUpFailure({required this.message});

  @override
  List<Object> get props => [message];
}

// email otp verification
final class AuthOtpEmailSending extends AuthState {}

final class AuthOtpEmailSent extends AuthState {
  final String email;
  final String otp;

  const AuthOtpEmailSent({
    required this.email,
    required this.otp,
  });

  @override
  List<Object> get props => [email, otp];
}

final class AuthOtpEmailFailedToSend extends AuthState {
  final String message;

  const AuthOtpEmailFailedToSend({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthOtpVerified extends AuthState {}

final class AuthOtpNotVerified extends AuthState {}

// onboarding email
final class AuthSendingOnboardingEmail extends AuthState {}

final class AuthOnboardingEmailSent extends AuthState {}

final class AuthOnboardingEmailFailedToSend extends AuthState {
  final String message;

  const AuthOnboardingEmailFailedToSend({required this.message});

  @override
  List<Object> get props => [message];
}

// password reset
final class AuthSendingPasswordResetEmail extends AuthState {}

final class AuthPasswordResetEmailSent extends AuthState {}

final class AuthPasswordResetEmailFailedToSend extends AuthState {
  final String message;

  const AuthPasswordResetEmailFailedToSend({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthPasswordResetLoading extends AuthState {}

final class AuthPasswordResetSuccessful extends AuthState {}

final class AuthPasswordResetFailed extends AuthState {
  final String message;

  const AuthPasswordResetFailed({required this.message});

  @override
  List<Object> get props => [message];
}
