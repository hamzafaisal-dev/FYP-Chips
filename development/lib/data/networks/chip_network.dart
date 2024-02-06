import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChipsFirestoreClient {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  ChipsFirestoreClient({
    required this.firestore,
    required this.firebaseAuth,
  });

  Future<List<ChipModel>> getAllChips() async {
    // fetches all documents in the resources collection
    final chips =
        await firestore.collection('chips').orderBy('createdAt').get();

    // resources.docs returns a list of QueryDocumentSnapshot
    // maps over the list, converts each document into a Resource, returns list of Resources
    List<ChipModel> allFetchedResources = chips.docs.map((docSnapshot) {
      return ChipModel.fromMap(docSnapshot.data());
    }).toList();

    return allFetchedResources;
  }

  Stream<List<ChipModel>> getAllChipsStream() {
    return firestore
        .collection('chips')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map(
                (docSnapshot) => ChipModel.fromMap(docSnapshot.data()),
              )
              .toList(),
        );
  }

  Future<UserModel> uploadChip(
    String jobTitle,
    String companyName,
    String description,
    String jobMode,
    List<String> locations,
    String jobType,
    int experienceRequired,
    DateTime deadline,
    List<dynamic> skills,
    double salary,
    UserModel updatedUser,
    String uploaderAvatar,
  ) async {
    String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();

    // final String? currentUserId = firebaseAuth.currentUser?.uid;

    // DocumentSnapshot userSnapshot =
    //     await firestore.collection('users').doc(currentUserId).get();

    // if (!userSnapshot.exists) throw Exception('User does not exist');

    // Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // String username = userData['userName'];

    String username = updatedUser.userName;

    ChipModel newChip = ChipModel(
      chipId: '$jobTitle-$timeStamp',
      jobTitle: jobTitle,
      companyName: companyName,
      description: description,
      jobMode: jobMode,
      locations: locations,
      jobType: jobType,
      experienceRequired: experienceRequired,
      deadline: deadline,
      skills: skills,
      salary: salary,
      postedBy: username,
      reportCount: 0,
      isFlagged: false,
      isExpired: false,
      createdAt: DateTime.now(),
      isActive: true,
      isDeleted: false,
    );

    await firestore
        .collection('chips')
        .doc('$jobTitle-$timeStamp')
        .set(newChip.toMap());

    List<String> userPostedChips = updatedUser.postedChips;

    userPostedChips.add(newChip.chipId);

    updatedUser = updatedUser.copyWith(
      postedChips: userPostedChips,
    );

    // set the updated user in db
    await firestore
        .collection('users')
        .doc(updatedUser.userId)
        .update(updatedUser.toMap());

    return updatedUser;
  }

  Future<UserModel> deleteChip(String chipId, UserModel user) async {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(user.userId).get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    UserModel updatedUser = UserModel.fromMap(userData);

    List<String> postedChips = updatedUser.postedChips;

    if (postedChips.any((postedResource) => postedResource == chipId)) {
      postedChips.remove(chipId);

      // postedChips.removeWhere((postedResource) => postedResource == chipId);

      updatedUser = updatedUser.copyWith(postedChips: postedChips);

      await firestore
          .collection('users')
          .doc(user.userId)
          .update(updatedUser.toMap());

      await firestore.collection('chips').doc(chipId).delete();
    }

    return updatedUser;
  }
}
