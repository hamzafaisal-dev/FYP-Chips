part of 'autofill_bloc.dart';

abstract class AutofillState extends Equatable {
  const AutofillState();

  @override
  List<Object> get props => [];
}

class AutofillInitial extends AutofillState {}

class AutofillLoading extends AutofillState {}

class AutofillSuccess extends AutofillState {
  final Map<String, dynamic> autoFillResponse;

  const AutofillSuccess({required this.autoFillResponse});
}

class AutofillError extends AutofillState {
  final String errorMsg;

  const AutofillError({required this.errorMsg});
}
