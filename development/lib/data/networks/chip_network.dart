import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class ChipNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // get list of all chips (not used anywhere but don't remove)
  Future<List<ChipModel>> getAllChips() async {
    final chips = await _firestore
        .collection('chips')
        .orderBy('createdAt', descending: true)
        .get();

    List<ChipModel> allFetchedChips = chips.docs.map((docSnapshot) {
      return ChipModel.fromMap(docSnapshot.data());
    }).toList();

    return allFetchedChips;
  }

  // get all chips stream
  Stream<List<ChipModel>> getAllChipsStream() {
    return _firestore
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

  // upload file to firebase storage
  // returns the download url of given file
  Future<String> uploadFileToFirebaseStorage(
    File file,
    String userId,
  ) async {
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = basename(file.path);

    if (file.path == '') return '';

    final storageRef = _firebaseStorage
        .ref()
        .child('documents')
        .child(userId)
        .child('$fileName-$currentTimeStamp');

    final metadata = SettableMetadata(
      customMetadata: {'originalName': fileName},
      contentType: Helpers.getMimeType(file),
    );

    await storageRef.putFile(
      file,
      metadata,
    );

    String fileUrl = await storageRef.getDownloadURL();

    return fileUrl;
  }

  // post chip
  Future<UserModel> postChip(
    String jobTitle,
    String employer,
    String applicationLink,
    String? description,
    String? jobMode,
    File? chipFile,
    List<String>? locations,
    String? jobType,
    int? experienceRequired,
    DateTime deadline,
    List<dynamic> skills,
    double? salary,
    UserModel currentUser,
  ) async {
    //
    late UserModel updatedUser;

    String username = currentUser.username;
    String chipId = const Uuid().v4();

    String chipFileUrl = "";
    if (chipFile != null) {
      chipFileUrl =
          await uploadFileToFirebaseStorage(chipFile, currentUser.userId);
    }

    ChipModel newChip = ChipModel(
      chipId: chipId,
      jobTitle: jobTitle,
      companyName: employer,
      applicationLink: applicationLink,
      description: description,
      jobMode: jobMode,
      imageUrl: chipFileUrl,
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

    // set newly created chip in firestore
    await _firestore.collection('chips').doc(chipId).set(newChip.toMap());

    // get user's array of posted chips
    List<String> userPostedChips = currentUser.postedChips;

    // add the id of the newly created chip to user's posted chips array
    userPostedChips.add(newChip.chipId);

    // update the user's UserModel accordingly
    updatedUser = currentUser.copyWith(
      postedChips: userPostedChips,
    );

    // set the updated user in _firestore
    await _firestore
        .collection('users')
        .doc(updatedUser.userId)
        .update(updatedUser.toMap());

    return updatedUser;
  }

  // delete chip
  Future<UserModel> deleteChip(String chipId, UserModel currentUser) async {
    late UserModel updatedUser;

    // get user data from firestore
    DocumentSnapshot userSnapshot =
        await _firestore.collection('users').doc(currentUser.userId).get();

    // cast user's data as a Map<String, dynamic>
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    // convert user map to UserModel
    UserModel user = UserModel.fromMap(userData);

    // get user's posted chips and put them in new 'postedChips' variable
    List<String> postedChips = user.postedChips;

    // if the chip to be deleted exists in user's posted chips array, it is deleted from the array
    if (postedChips.any((postedChip) => postedChip == chipId)) {
      postedChips.remove(chipId);

      updatedUser = user.copyWith(postedChips: postedChips);

      await _firestore
          .collection('users')
          .doc(user.userId)
          .update(updatedUser.toMap());

      // chip is also deleted from firestore
      await _firestore.collection('chips').doc(chipId).delete();
    }

    return updatedUser;
  }
}
