import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

class NotificationNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user chips stream
  Stream<List<NotificationModel>> getUsersNotifications(UserModel currentUser) {
    return _firestore
        .collection('notifications')
        .where('recipientId', isEqualTo: currentUser.username)
        // .where('read', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => NotificationModel.fromJson(docSnapshot.data()))
            .toList());
  }

  void createNotification(
      String notifType, ChipModel chip, UserModel currentUser) async {
    // if chip is user's own posted chip then no notif will be generated
    if (!currentUser.postedChips.contains(chip.chipId)) {
      String newNotificationId = const Uuid().v4();

      // calculate timestamp for 24 hrs ago
      int twentyFourHoursAgoTimestamp = DateTime.now()
          .subtract(const Duration(hours: 24))
          .millisecondsSinceEpoch;

      // because fuck clean code
      String keyword = notifType == 'bookmark'
          ? 'saved'
          : notifType == 'like'
              ? 'liked'
              : notifType == 'comment'
                  ? 'commented on'
                  : '';

      print(notifType);

      // check if a notif with the same type, jobId, senderId, and recipientId exists in the past 24 hours
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('type', isEqualTo: notifType)
          .where('jobId', isEqualTo: chip.chipId)
          .where('senderId', isEqualTo: currentUser.userId)
          .where('recipientId', isEqualTo: chip.postedBy)
          .where('timestamp', isGreaterThan: twentyFourHoursAgoTimestamp)
          .limit(1)
          .get();

      // if no such notification exists, generate a new notif
      if (querySnapshot.docs.isEmpty) {
        NotificationModel newNotification = NotificationModel(
          notificationId: newNotificationId,
          recipientId: chip.postedBy,
          senderId: currentUser.userId,
          jobId: chip.chipId,
          type: 'bookmark',
          message: '${currentUser.name} $keyword your chip!',
          timestamp: DateTime.now(),
          read: false,
        );

        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(newNotificationId)
            .set(newNotification.toJson());
      } else {
        print('ppop is ${querySnapshot.docs.first.data()}');
      }
    }
  }

  void updateNotification(NotificationModel notification) async {
    await _firestore
        .collection('notifications')
        .doc(notification.notificationId)
        .update(notification.toJson());
  }
}
