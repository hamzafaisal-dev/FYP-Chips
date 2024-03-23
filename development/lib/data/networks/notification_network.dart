import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';

class NotificationNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user chips stream
  Stream<List<NotificationModel>> getUsersNotifications(UserModel currentUser) {
    return _firestore
        .collection('notifications')
        .where('recipientId', isEqualTo: currentUser.username)
        .where('read', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => NotificationModel.fromJson(docSnapshot.data()))
            .toList());
  }
}
