import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> findUserByUsername(String username) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('userName', isEqualTo: username)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      throw Exception('User not found with username: $username');
    }

    DocumentSnapshot userSnapshot = querySnapshot.docs.first;

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    UserModel user = UserModel.fromMap(userData);

    return user;
  }

  Future<List<UserModel>> findUsersByUsernames(List<String> usernames) async {
    List<UserModel> users = [];

    for (String username in usernames) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('userName', isEqualTo: username)
          .limit(1)
          .get();

      // if user with the given username is found, add it to the list
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(userData);
        users.add(user);
      }
    }

    // check if any usernames were not found
    if (users.length < usernames.length) {
      List<String> notFoundUsernames = usernames
          .where((username) => !users.any((user) => user.username == username))
          .toList();

      throw Exception('Users not found with usernames: $notFoundUsernames');
    }

    return users;
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

    UserModel user = await findUserByUsername(currentUser.username);
    UserModel userWhoPostedChip = await findUserByUsername(chip.postedBy);

    // get user's favorited chips and put them in new 'favoritedChips' variable
    List<String> favoritedChips = user.favoritedChips;

    List<String> chipFavoritedBy = chip.favoritedBy;

    int chipPostersBookmarkCount = userWhoPostedChip.bookmarkCount;

    // if the chip to be bookmarked already exists in user's favorited chips array, it is deleted from the array
    if (favoritedChips.contains(chip.chipId)) {
      favoritedChips.remove(chip.chipId);
      chipFavoritedBy.remove(user.username);
      chipPostersBookmarkCount -= 1;
    } else {
      favoritedChips.insert(0, chip.chipId);
      chipFavoritedBy.insert(0, user.username);
      chipPostersBookmarkCount += 1;

      isBookmarked = true;
    }

    // roza lag raha hai, pata nahi kia bakwas likhi hai but it works
    if (userWhoPostedChip.userId == currentUser.userId) {
      updatedUser = user.copyWith(
        favoritedChips: favoritedChips,
        bookmarkCount: chipPostersBookmarkCount,
      );

      updatedUser = await updateUser(updatedUser);
    } else {
      userWhoPostedChip =
          userWhoPostedChip.copyWith(bookmarkCount: chipPostersBookmarkCount);

      await updateUser(userWhoPostedChip);

      updatedUser = user.copyWith(favoritedChips: favoritedChips);

      await updateUser(updatedUser);
    }

    await _firestore
        .collection('chips')
        .doc(chip.chipId)
        .update(chip.copyWith(favoritedBy: chipFavoritedBy).toMap());

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
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email!,
          password: oldPassword,
        );
      } catch (error) {
        throw 'Invalid password!⚠️';
      }
      if (oldPassword == newPassword) {
        throw 'New password cannot be the same as old password!🤣🫵🏼';
      }
      await user.updatePassword(newPassword);
    } catch (error) {
      throw error.toString();
    }
  }
}
