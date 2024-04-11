import 'package:bloc/bloc.dart';
import 'package:development/data/repositories/shared_pref_repo.dart';
import 'package:meta/meta.dart';

part 'shared_pref_state.dart';

class SharedPrefCubit extends Cubit<SharedPrefState> {
  SharedPrefCubit() : super(SharedPrefInitial());

  final SharedRefRepository _sharedPrefRepository = SharedRefRepository();

  void setData(Map<String, dynamic> selectedFilters) async {
    emit(SharedPrefLoading());
    try {
      await _sharedPrefRepository.setData(selectedFilters);

      emit(SharedPrefDataSet());
      // emit(SharedPrefInitial());
    } catch (e) {
      emit(SharedPrefFailure(e.toString()));
      // emit(SharedPrefInitial());
    }
  }

  void getData() async {
    emit(SharedPrefLoading());
    try {
      Map<String, dynamic> data = await _sharedPrefRepository.getData();

      emit(SharedPrefDataGet(data));
      // emit(SharedPrefInitial());
    } catch (e) {
      emit(SharedPrefFailure(e.toString()));
      // emit(SharedPrefInitial());
    }
  }
}
