import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:development/data/repositories/autofill_repository.dart';
import 'package:equatable/equatable.dart';
part 'autofill_event.dart';
part 'autofill_state.dart';

class AutofillBloc extends Bloc<AutofillEvent, AutofillState> {
  final AutofillRepository _autofillRepository = AutofillRepository();

  AutofillBloc() : super(AutofillInitial()) {
    on<AutofillChipDetailsEvent>((event, emit) async {
      String chipDescription = event.chipDetails["chipDescription"];
      File? chipFile = event.chipDetails["chipFile"];

// if chipFile != null, extract text from image using OCR (create new func for OCR)
// String context = chipDescription + (whatever text extracted from image)
// pass context to sendAutofillRequestN

      try {
        emit(AutofillLoading());

        Map<String, dynamic> autoFillResponse =
            await _autofillRepository.sendAutofillRequestN(chipDescription);

        emit(AutofillSuccess(autoFillResponse: autoFillResponse));
        // emit(AutofillInitial());
      } catch (error) {
        emit(AutofillError(errorMsg: error.toString()));
      }
    });
  }
}
