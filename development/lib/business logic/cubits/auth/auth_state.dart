part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

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
final class AuthCheckingIfUserExists extends AuthState {}

final class AuthFailureCheckingUserExistance extends AuthState {
  final String message;

  const AuthFailureCheckingUserExistance({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthUserExists extends AuthState {}

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
  final String name;
  final String password;

  const AuthOtpEmailSent({
    required this.email,
    required this.otp,
    required this.name,
    required this.password,
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

final class AuthOtpVerified extends AuthState {
  final String email;
  final String name;
  final String password;

  const AuthOtpVerified({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object> get props => [email, name, password];
}

final class AuthOtpNotVerified extends AuthState {
  final String email;
  final String name;
  final String password;

  const AuthOtpNotVerified({
    required this.email,
    required this.name,
    required this.password,
  });

  @override
  List<Object> get props => [email, name, password];
}

// onboarding email
final class AuthSendingOnboardingEmail extends AuthState {}

final class AuthOnboardingEmailSent extends AuthState {}

final class AuthOnboardingEmailFailedToSend extends AuthState {
  final String message;

  const AuthOnboardingEmailFailedToSend({required this.message});

  @override
  List<Object> get props => [message];
}

// other
final class AuthPasswordResetEmailSent extends AuthState {}

final class AuthPasswordResetEmailFailed extends AuthState {
  final String message;

  const AuthPasswordResetEmailFailed({required this.message});

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
