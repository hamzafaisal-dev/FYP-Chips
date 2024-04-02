import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/notification_network.dart';

class NotificationRepository {
  final NotificationNetwork _notificationNetwork = NotificationNetwork();

  // get stream of all notification
  Stream<List<NotificationModel>> getAllNotificationStream(
      UserModel currentUser) {
    return _notificationNetwork.getUsersNotifications(currentUser);
  }

  void updateNotification(NotificationModel notification) {
    _notificationNetwork.updateNotification(notification);
  }
}
