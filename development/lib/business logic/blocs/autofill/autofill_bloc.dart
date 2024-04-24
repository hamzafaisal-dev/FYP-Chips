import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:development/data/repositories/autofill_repository.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:equatable/equatable.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
part 'autofill_event.dart';
part 'autofill_state.dart';

class AutofillBloc extends Bloc<AutofillEvent, AutofillState> {
  final AutofillRepository _autofillRepository = AutofillRepository();

  AutofillBloc() : super(AutofillInitial()) {
    on<AutofillChipDetailsEvent>((event, emit) async {
      String extractedText = '';

      String chipDescription = event.chipDetails["chipDescription"];
      File? chipFile = event.chipDetails["chipFile"];

      try {
        emit(AutofillLoading());

        // if chipFile != null, extract text from image using OCR
        if (chipFile != null) extractedText = await extractImageText(chipFile);

        String context = chipDescription + extractedText;

        Map<String, dynamic> autoFillResponse =
            await _autofillRepository.sendAutofillRequestN(context);

        emit(AutofillSuccess(autoFillResponse: autoFillResponse));
        emit(AutofillInitial());
      } catch (error) {
        emit(AutofillError(errorMsg: error.toString()));
      }
    });
  }

  Future<String> extractImageText(File image) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFile(image);
    final RecognizedText recognisedText =
        await textRecognizer.processImage(inputImage);
    String extractedText = recognisedText.text;
    await textRecognizer.close();
    return extractedText;
  }
}
