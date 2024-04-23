import 'package:bloc/bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/contact_us_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  final ContactUsRepository _contactUsRepository = ContactUsRepository();

  void contactUs(UserModel user, String message) async {
    emit(ContactUsLoading());
    try {
      final response = await _contactUsRepository.contactUs(user, message);
      emit(ContactUsSuccess(response['status']));
      emit(ContactUsInitial());
    } catch (e) {
      emit(ContactUsFailure(e.toString()));
      emit(ContactUsInitial());
    }
  }
}
