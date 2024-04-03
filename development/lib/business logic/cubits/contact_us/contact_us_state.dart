part of 'contact_us_cubit.dart';

sealed class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

final class ContactUsInitial extends ContactUsState {}

final class ContactUsLoading extends ContactUsState {}

final class ContactUsSuccess extends ContactUsState {
  final String message;

  const ContactUsSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class ContactUsFailure extends ContactUsState {
  final String message;

  const ContactUsFailure(this.message);

  @override
  List<Object> get props => [message];
}
