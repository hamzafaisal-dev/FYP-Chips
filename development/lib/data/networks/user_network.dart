import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

class UserNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

      String newNotificationId = const Uuid().v4();

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

      await _firestore
          .collection('notifications')
          .doc(newNotificationId)
          .set(newNotification.toJson());
    }

    updatedUser = user.copyWith(favoritedChips: favoritedChips);

    await _firestore
        .collection('users')
        .doc(user.userId)
        .update(updatedUser.toMap());

    return {"updatedUser": updatedUser, "isBookmarked": isBookmarked};
  }

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
}
