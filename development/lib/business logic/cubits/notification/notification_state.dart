part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

abstract class ChipState extends Equatable {
  const ChipState([List props = const []]) : super();
}

final class NotificationInitial extends NotificationState {}

class NotificationsStreamLoaded extends NotificationState {
  final Stream<List<NotificationModel>> notifications;

  const NotificationsStreamLoaded({required this.notifications});
}

// generic loading class for notifications
final class NotificationLoadingState extends NotificationState {}

// generic error class for notifications
final class NotificationErrorState extends NotificationState {
  final String errorMessage;

  const NotificationErrorState({required this.errorMessage});
}
