import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static void createChipsNotification(String userName) {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) async {
        if (!isAllowed) {
          await AwesomeNotifications().requestPermissionToSendNotifications();

          _createNotification(userName);
        } else {
          _createNotification(userName);
        }
      },
    );
  }

  static void _createNotification(String userName) {
    int currentYear = DateTime.now().year;
    int currentMonth = DateTime.now().month;
    int currentDay = DateTime.now().day;
    int currentHour = DateTime.now().hour;
    int currentMinute = DateTime.now().minute;

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 56,
        channelKey: 'chips_notification_channel',
        title: 'Fresh Chips!',
        body: 'Hey $userName, new chips were just added! Check them out now!',
        wakeUpScreen: true,
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime(
          currentYear,
          currentMonth,
          currentDay,
          currentHour,
          currentMinute + 1,
        ),
      ),
    );
  }
}
