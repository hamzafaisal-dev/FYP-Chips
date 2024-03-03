import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class ChipNetwork {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  ChipNetwork({
    required this.firestore,
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  // get all chips list
  Future<List<ChipModel>> getAllChips() async {
    final chips = await firestore
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

  // upload file to firebase storage
  // returns the download url of given file
  Future<String> uploadFileToFirebaseStorage(
    File file,
    String userId,
  ) async {
    String currentTimeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = basename(file.path);

    if (file.path == '') return '';

    final storageRef = firebaseStorage
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
    UserModel updatedUser,
  ) async {
    String username = updatedUser.username;
    String chipId = const Uuid().v4();

    print('chipFile: $chipFile');

    String chipFileUrl = "";
    if (chipFile != null) {
      chipFileUrl =
          await uploadFileToFirebaseStorage(chipFile, updatedUser.userId);
    }

    print('chipFileURL: $chipFileUrl');

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

    await firestore.collection('chips').doc(chipId).set(newChip.toMap());

    List<String> userPostedChips = updatedUser.postedChips;

    userPostedChips.add(newChip.chipId);

    updatedUser = updatedUser.copyWith(
      postedChips: userPostedChips,
    );

    // set the updated user in firestore
    await firestore
        .collection('users')
        .doc(updatedUser.userId)
        .update(updatedUser.toMap());

    return updatedUser;
  }

  // delete chip
  Future<UserModel> deleteChip(String chipId, UserModel user) async {
    DocumentSnapshot userSnapshot =
        await firestore.collection('users').doc(user.userId).get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    UserModel updatedUser = UserModel.fromMap(userData);

    List<String> postedChips = updatedUser.postedChips;

    if (postedChips.any((postedChip) => postedChip == chipId)) {
      postedChips.remove(chipId);

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
