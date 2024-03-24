import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class UserNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // shift this bad boi to noti cubit and call in ui
  void generateNotification(ChipModel chip, UserModel currentUser) async {
    String newNotificationId = const Uuid().v4();

    // calculate timestamp for 24 hrs ago
    int twentyFourHoursAgoTimestamp = DateTime.now()
        .subtract(const Duration(hours: 24))
        .millisecondsSinceEpoch;

    // check if a notif with the same jobId, senderId, and recipientId exists in the past 24 hours
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
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
        message: '${currentUser.name} favorited your chip!',
        timestamp: DateTime.now(),
        read: false,
      );

      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(newNotificationId)
          .set(newNotification.toJson());
    }
  }

  // Get user chips stream
  Stream<List<ChipModel>> getUserChipsStream(String username) {
    return _firestore
        .collection('chips')
        .where('postedBy', isEqualTo: username)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => ChipModel.fromMap(docSnapshot.data()))
            .toList())
        .handleError((error) {
      throw Exception(error.toString());
    });
  }

  // get user chips
  Future<List<ChipModel>> getUserChips(List<String> chipIds) async {
    List<ChipModel> fetchedChips = [];

    for (String chipId in chipIds) {
      final chipSnapshot = await _firestore
          .collection('chips')
          .where('chipId', isEqualTo: chipId)
          .get();

      if (chipSnapshot.docs.isNotEmpty) {
        ChipModel chip = ChipModel.fromMap(chipSnapshot.docs.first.data());
        fetchedChips.add(chip);
      }
    }

    return fetchedChips;
  }

  // bookmark chip
  Future<Map<String, dynamic>> bookmarkChip(
      ChipModel chip, UserModel currentUser) async {
    late UserModel updatedUser;
    bool isBookmarked = false;

    // get user data from firestore
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(currentUser.userId).get();

    // cast user's data as a Map<String, dynamic>
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // convert user map to UserModel
    UserModel user = UserModel.fromMap(userData);

    // get user's favorited chips and put them in new 'favoritedChips' variable
    List<String> favoritedChips = user.favoritedChips;

    // if the chip to be bookmarked already exists in user's favorited chips array, it is deleted from the array
    if (favoritedChips.contains(chip.chipId)) {
      favoritedChips.remove(chip.chipId);
    } else {
      favoritedChips.insert(0, chip.chipId);
      isBookmarked = true;

      // if chip is user's own posted chip then no notif will be generated
      if (!currentUser.postedChips.contains(chip.chipId)) {
        generateNotification(chip, currentUser);
      }
    }

    updatedUser = user.copyWith(favoritedChips: favoritedChips);

    await _firestore
        .collection('users')
        .doc(user.userId)
        .update(updatedUser.toMap());

    return {"updatedUser": updatedUser, "isBookmarked": isBookmarked};
  }

  // mark chip as applied
  Future<Map<String, dynamic>> markChipAsApplied(
    String chipId,
    UserModel currentUser,
  ) async {
    late UserModel updatedUser;
    bool isApplied = false;

    // get user data from firestore
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(currentUser.userId).get();

    // cast user's data as a Map<String, dynamic>
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // convert user map to UserModel
    UserModel user = UserModel.fromMap(userData);

    // get user's favorited chips and put them in new 'favoritedChips' variable
    List<String> appliedChips = user.appliedChips;

    // if the chip to be bookmarked already exists in user's favorited chips array, it is deleted from the array
    if (appliedChips.contains(chipId)) {
      appliedChips.remove(chipId);
    } else {
      appliedChips.insert(0, chipId);
      isApplied = true;
    }

    updatedUser = user.copyWith(appliedChips: appliedChips);

    await _firestore
        .collection('users')
        .doc(user.userId)
        .update(updatedUser.toMap());

    return {"updatedUser": updatedUser, "isApplied": isApplied};
  }

  // update user
  Future<UserModel> updateUser(UserModel user) async {
    await _firestore
        .collection('users')
        .doc(user.userId)
        .update(user.toMap())
        .catchError((error) {
      throw Exception(error.toString());
    });

    return user;
  }

  // update user password
  Future<void> updateUserPassword(
      String oldPassword, String newPassword) async {
    try {
      User user = _firebaseAuth.currentUser!;
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email!,
        password: oldPassword,
      );
      if (userCredential.user == null) {
        throw Exception('Invalid password!');
      }
      await user.updatePassword(newPassword);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
