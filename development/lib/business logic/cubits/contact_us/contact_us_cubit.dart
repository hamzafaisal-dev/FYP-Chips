import 'package:bloc/bloc.dart';
import 'package:development/data/repositories/contact_us_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());

  final ContactUsRepository _contactUsRepository = ContactUsRepository();

  void contactUs(String username, String message) async {
    print('ContactUsCubit: contactUs');
    emit(ContactUsLoading());
    try {
      print('ContactUsCubit: try');
      final response = await _contactUsRepository.contactUs(username, message);
      emit(ContactUsSuccess(response['status']));
      print('ContactUsCubit: success');
    } catch (e) {
      print('ContactUsCubit: catch');
      emit(ContactUsFailure(e.toString()));
      print(e.toString());
    }
  }
}
