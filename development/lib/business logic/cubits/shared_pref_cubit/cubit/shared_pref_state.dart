part of 'shared_pref_cubit.dart';

@immutable
sealed class SharedPrefState {}

final class SharedPrefInitial extends SharedPrefState {}

final class SharedPrefLoading extends SharedPrefState {}

final class SharedPrefDataGet extends SharedPrefState {
  final Map<String, dynamic> data;

  SharedPrefDataGet(this.data);
}

final class SharedPrefDataSet extends SharedPrefState {}

final class SharedPrefFailure extends SharedPrefState {
  final String message;

  SharedPrefFailure(this.message);
}
