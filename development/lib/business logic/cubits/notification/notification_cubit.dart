import 'package:bloc/bloc.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/notification_repository.dart';
import 'package:equatable/equatable.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _notificationRepository =
      NotificationRepository();

  NotificationCubit() : super(NotificationInitial());

  // fetch user notifications stream
  void fetchUserNotificationsStream(UserModel currentUser) async {
    emit(NotificationLoadingState());
    try {
      Stream<List<NotificationModel>> notificationStream =
          _notificationRepository.getAllNotificationStream(currentUser);

      emit(NotificationsStreamLoaded(notifications: notificationStream));
    } catch (error) {
      emit(NotificationErrorState(errorMessage: error.toString()));
    }
  }
}
