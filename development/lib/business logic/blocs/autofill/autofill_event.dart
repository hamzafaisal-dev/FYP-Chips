part of 'autofill_bloc.dart';

sealed class AutofillEvent extends Equatable {
  const AutofillEvent();

  @override
  List<Object> get props => [];
}

class AutofillChipDetailsEvent extends AutofillEvent {
  final Map<String, dynamic> chipDetails; // this map contains text and image

  const AutofillChipDetailsEvent({required this.chipDetails});
}
