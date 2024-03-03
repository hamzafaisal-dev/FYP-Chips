part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel user;

  const AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthSignedOut extends AuthState {}

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

// other
final class AuthPasswordResetEmailSent extends AuthState {}

final class AuthPasswordResetEmailFailed extends AuthState {
  final String message;

  const AuthPasswordResetEmailFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthPasswordReset extends AuthState {}

final class AuthPasswordResetFailed extends AuthState {
  final String message;

  const AuthPasswordResetFailed({required this.message});

  @override
  List<Object> get props => [message];
}
