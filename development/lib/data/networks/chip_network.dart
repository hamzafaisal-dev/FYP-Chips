import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/constants/network_urls.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ChipNetwork {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final String NSFW_API_ENDPOINT =
      'https://chips.pythonanywhere.com/profanity/image';

  // get a chip by its chipId
  Future<ChipModel?> getChipById(String chipId) async {
    final chipDoc = await _firestore.collection('chips').doc(chipId).get();

    if (chipDoc.exists) {
      return ChipModel.fromMap(chipDoc.data()!);
    } else {
      return null;
    }
  }

  // get all searched chips
  Future<List<ChipModel>> getAllSearchedChips(String searchText) async {
    final chips = await _firestore
        .collection('chips')
        .orderBy('createdAt', descending: true)
        .get();

    List<ChipModel> allFetchedChips = chips.docs
        .map((docSnapshot) => ChipModel.fromMap(docSnapshot.data()))
        .where((chip) =>
            chip.jobTitle.toLowerCase().contains(searchText.toLowerCase()) ||
            chip.companyName.toLowerCase().contains(searchText.toLowerCase()) ||
            chip.skills!.contains(searchText.toLowerCase()))
        .toList();

    return allFetchedChips;
  }

  // get all chips future
  Future<List<ChipModel>> getAllChipsFuture() async {
    QuerySnapshot snapshot = await _firestore
        .collection('chips')
        .orderBy('createdAt', descending: true)
        .get();

    List<ChipModel> chips = snapshot.docs
        .map(
          (docSnapshot) => ChipModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>,
          ),
        )
        .toList();

    return chips;
  }

  // get a particular users psoted chips
  Future<List<ChipModel>> getUsersChips(String postedBy) async {
    QuerySnapshot snapshot = await _firestore
        .collection('chips')
        .where('postedBy', isEqualTo: postedBy)
        .orderBy('createdAt', descending: true)
        .get();

    List<ChipModel> chips = snapshot.docs
        .map(
          (docSnapshot) => ChipModel.fromMap(
            docSnapshot.data() as Map<String, dynamic>,
          ),
        )
        .toList();

    return chips;
  }

  // get filtered chips
  Future<List<ChipModel>> getFilteredChips(Map<String, dynamic> filters) async {
    List<String> selectedJobModes = filters['jobModes'] as List<String>;
    List<String> selectedJobTypes = filters['jobTypes'] as List<String>;

    Query query = _firestore.collection('chips');

    List<ChipModel> modeQueryResult = [];
    List<ChipModel> typeQueryResult = [];

    if (selectedJobModes.isNotEmpty) {
      QuerySnapshot modeSnapshot = await query
          .where('jobMode', whereIn: selectedJobModes)
          .orderBy('createdAt', descending: true)
          .get();

      modeQueryResult = modeSnapshot.docs
          .map((docSnapshot) =>
              ChipModel.fromMap(docSnapshot.data() as Map<String, dynamic>))
          .toList();
    }

    if (selectedJobTypes.isNotEmpty) {
      QuerySnapshot typeSnapshot = await query
          .where('jobType', whereIn: selectedJobTypes)
          .orderBy('createdAt', descending: true)
          .get();

      typeQueryResult = typeSnapshot.docs
          .map((docSnapshot) =>
              ChipModel.fromMap(docSnapshot.data() as Map<String, dynamic>))
          .toList();
    }

    List<ChipModel> filteredChips = [];
    filteredChips.addAll(modeQueryResult);
    filteredChips.addAll(typeQueryResult);

    print('modeQueryResult: $modeQueryResult');
    print('typeQueryResult: $typeQueryResult');
    print('filteredChips: ${filteredChips.length}');

    return filteredChips;
  }

  // returns the download url of given file
  Future<String> uploadFileToFirebaseStorage(
    File file,
    String userId,
  ) async {
    if (file.path == '') return '';

    String fileName = basename(file.path);
    String fileId = const Uuid().v4();

    final storageRef =
        _firebaseStorage.ref().child('documents').child(userId).child(fileId);

    final metadata = SettableMetadata(
      customMetadata: {'originalName': fileName},
      contentType: Helpers.getMimeType(file),
    );

    await storageRef.putFile(file, metadata);

    String fileUrl = await storageRef.getDownloadURL();

    print(fileUrl);

    String result = await checkimageProfanity(fileUrl);

    if (result == 'Profane') throw 'profane';

    return fileUrl;
  }

  //network method for image profanity
  Future<String> checkimageProfanity(String input) async {
    final url = Uri.parse(NSFW_API_ENDPOINT);

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({'image_link': input});

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);
        return responsedata['result'];
      } else {
        throw response.statusCode;
      }
    } catch (e) {
      rethrow;
    }
  }

  //network method for english profanity
  Future<Map<String, dynamic>> checkEnglishProfanity(String input) async {
    final url = Uri.parse('https://chips.pythonanywhere.com/profanity/english');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'input': input,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);
        return {
          'Profane': responsedata['Profane'].toString(),
          'Clean': responsedata['Clean'].toString(),
        };
      } else {
        return {
          'error': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'error': 'Error: $e',
      };
    }
  }

  //network method for roman urdu profanity
  Future<Map<String, dynamic>> checkUrduProfanity(String input) async {
    final url = Uri.parse('https://chips.pythonanywhere.com/profanity/urdu');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'input': input,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);
        return {
          'Profane': responsedata['Profane'].toString(),
        };
      } else {
        return {
          'error': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'error': 'Error: $e',
      };
    }
  }

  //network method for jobnojob
  Future<Map<String, dynamic>> checkJobValidity(String input) async {
    final url = Uri.parse('https://chips.pythonanywhere.com/job');

    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({'input': input});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responsedata = jsonDecode(response.body);

        print('responsedata is $responsedata');

        return {
          'prediction': responsedata['prediction'].toString(),
          'confidence': responsedata['confidence'].toString(),
        };
      } else {
        return {
          'error': 'Error: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'error': 'Error: $e',
      };
    }
  }

  // add chip to google sheet
  // Future<Map<String, dynamic>> addChipToGoogleSheet(ChipModel chip) async {
  //   final url = Uri.https(NetworkURLS.baseUrl1, '/addChip');
  //   final headers = {'Content-Type': 'application/json'};
  //   DateTime deadline = chip.deadline;
  //   String formattedDeadline =
  //       '${deadline.year}-${Helpers.addLeadingZero(deadline.month)}-${Helpers.addLeadingZero(deadline.day)}';
  //   final body = jsonEncode({
  //     'deadline': formattedDeadline,
  //     'title': chip.jobTitle.toString(),
  //     'company': chip.companyName.toString(),
  //     'where_to_apply': chip.applicationLink.toString(),
  //   });

  //   try {
  //     final response = await http.post(url, headers: headers, body: body);

  //     if (response.statusCode == 200) {
  //       return {'success': true};
  //     } else {
  //       return {
  //         'success': false,
  //         'message': 'Failed to add chip to google sheet',
  //       };
  //     }
  //   } catch (e) {
  //     return {
  //       'success': false,
  //       'message': 'Error: $e',
  //     };
  //   }
  // }

  // post chip
  Future<UserModel> postChip({required Map<String, dynamic> chipMap}) async {
    //
    late UserModel updatedUser;

    // get all chip properties from map
    String jobTitle = chipMap['jobTitle'];
    String companyName = chipMap['companyName'];
    String applicationLink = chipMap['applicationLink'];
    String? description = chipMap['description'];
    String? jobMode = chipMap['jobMode'];
    File? chipFile = chipMap['chipFile'];
    List<String> locations = List<String>.from(chipMap['locations'] ?? []);
    String? jobType = chipMap['jobType'];
    int? experienceRequired = chipMap['experienceRequired'];
    DateTime deadline = chipMap['deadline'];
    List<String> skills = chipMap['skills'];
    double? salary = chipMap['salary'];
    UserModel currentUser = chipMap['currentUser'];

    String username = currentUser.username;
    String chipId = const Uuid().v4();

    // concatenate all user input to check for profanity and job validity
    String context = '$jobTitle $companyName $description';

    if (description != '') {
      Map<String, dynamic> jobValidityResponse =
          await checkJobValidity(context);

      if (int.parse(jobValidityResponse['prediction']) == 0) {
        throw 'not-job';
      }
    }

    Map<String, dynamic> englishProfanityResponse =
        await checkEnglishProfanity(context);

    Map<String, dynamic> urduProfanityResponse =
        await checkUrduProfanity(context);

    double englishProfanityScore =
        double.parse(englishProfanityResponse['Profane']);

    // urdu profanity ke liye sirf Profane ka true ya false return horaha hai
    bool urduProfanityScore = bool.parse(urduProfanityResponse['Profane']);

    if (englishProfanityScore >= 80 || urduProfanityScore) {
      throw 'profane';
    }

    // upload file to fb storage and get download URL
    String chipFileUrl = "";
    if (chipFile != null) {
      chipFileUrl =
          await uploadFileToFirebaseStorage(chipFile, currentUser.userId);
    }

    ChipModel newChip = ChipModel(
      chipId: chipId,
      jobTitle: jobTitle,
      companyName: companyName,
      applicationLink: applicationLink,
      description: description,
      jobMode: jobMode,
      imageUrl: chipFileUrl,
      locations: locations,
      jobType: jobType,
      experienceRequired: experienceRequired,
      deadline: deadline,
      likes: 0,
      dislikes: 0,
      comments: [],
      favoritedBy: [],
      likedBy: [],
      skills: skills,
      salary: salary,
      postedBy: username,
      posterPicture: currentUser.profilePictureUrl,
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

    // add chip to google sheet
    // await addChipToGoogleSheet(newChip);

    return updatedUser;
  }

  // edit chip
  Future<void> editChip({required Map<String, dynamic> chipMap}) async {
    //

    // get relevant chip properties from map
    String chipId = chipMap['chipId'];
    String jobTitle = chipMap['jobTitle'];
    String companyName = chipMap['companyName'];
    String description = chipMap['description'];

    // concatenate all user input to check for profanity
    String profanityContext = '$jobTitle + $companyName + $description';

    Map<String, dynamic> englishProfanityResponse =
        await checkEnglishProfanity(profanityContext);

    Map<String, dynamic> urduProfanityResponse =
        await checkUrduProfanity(profanityContext);

    double englishProfanityScore =
        double.parse(englishProfanityResponse['Profane']);

    double englishCleanScore = double.parse(englishProfanityResponse['Clean']);

    // aqalmando ne urdu profanity ke liye sirf Profane ka true ya false return karwayawa hai
    bool urduProfanityScore = bool.parse(urduProfanityResponse['Profane']);

    if (englishProfanityScore >= 70 || urduProfanityScore) {
      throw 'profane';
    }

    // ChipModel editedChip = ChipModel.fromMap(chipMap);

    // update chip
    await _firestore.collection('chips').doc(chipId).update(chipMap);
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

// get user's favorited chips and put them in new 'favoritedChips' variable
    List<String> favoritedChips = user.favoritedChips;

    // get user's applied chips and put them in new 'appliedChips' variable
    List<String> appliedChips = user.appliedChips;

    // if the chip to be deleted exists in user's posted chips array, it is deleted from the array
    if (postedChips.contains(chipId)) {
      postedChips.remove(chipId);
    }

    if (favoritedChips.contains(chipId)) {
      favoritedChips.remove(chipId);
    }

    if (appliedChips.contains(chipId)) {
      appliedChips.remove(chipId);
    }

    updatedUser = user.copyWith(
      postedChips: postedChips,
      favoritedChips: favoritedChips,
      appliedChips: appliedChips,
    );

    await _firestore
        .collection('users')
        .doc(updatedUser.userId)
        .update(updatedUser.toMap());

    // chip is also deleted from firestore
    await _firestore.collection('chips').doc(chipId).delete();

    Helpers.logEvent(
      updatedUser.userId,
      "delete-chip",
      [chipId],
    );

    return updatedUser;
  }
}
