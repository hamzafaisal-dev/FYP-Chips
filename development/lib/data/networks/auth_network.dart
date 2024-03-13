import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/constants/network_urls.dart';
import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class AuthNetwork {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream<User?> get userAuthChangeStream => _firebaseAuth.userChanges();

  // get current user
  Future<UserModel> getCurrentUser(User currentUser) async {
    try {
      DocumentSnapshot querySnapshot =
          await _firestore.collection('users').doc(currentUser.uid).get();
      Map<String, dynamic> userMap =
          querySnapshot.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(userMap);
      return user;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // email password sign in
  Future<UserModel> emailPasswordSignIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      UserModel authenticatedUser =
          UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);

      // print(authenticatedUser);

      return authenticatedUser;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // send otp email
  Future<Map<String, dynamic>> sendOtpEmail(String email, String name) async {
    final url = Uri.https(NetworkURLS.baseUrl1, '/sendOtpEmail');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': email,
      'name': name,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'otp': responseData['otp'].toString(),
          'receiver': responseData['receiver'].toString(),
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to send OTP email',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // add user email to google sheet
  Future<Map<String, dynamic>> addUserEmailToGoogleSheet(String email) async {
    final url = Uri.https(NetworkURLS.baseUrl1, '/addUser');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return {'success': true};
      } else {
        return {
          'success': false,
          'message': 'Failed to add user email to google sheet',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // verify otp
  bool verifyOtp(String userInput, String otp) {
    return userInput == otp;
  }

  // send onboarding email
  Future<Map<String, dynamic>> sendOnboardingEmail(
      String email, String name) async {
    final url = Uri.https(NetworkURLS.baseUrl1, '/sendWelcomeEmail');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'name': name});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'],
          'receiver': responseData['receiver'],
          'status': responseData['status'],
        };
      } else {
        return {
          'success': false,
          'message': 'Failed to send onboarding email',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }

  // email password sign up
  Future<UserModel> emailPasswordSignUp(
      String name, String email, String password) async {
    try {
      final newUserCredentials =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = newUserCredentials.user!.uid;

      UserModel newUser = UserModel(
        userId: userId,
        role: 'user',
        email: email,
        username: email.split('@')[0],
        name: name,
        postedChips: [],
        appliedChips: [],
        favoritedChips: [],
        binnedChips: [],
        preferences: {},
        reportCount: 0,
        isBanned: false,
        createdAt: DateTime.now(),
        updatedAt: null,
        isActive: true,
        isDeleted: false,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(newUserCredentials.user!.uid)
          .set(newUser.toMap());

      await addUserEmailToGoogleSheet(email);

      return newUser;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // check if user exists
  Future<bool> checkIfUserExists(String email) async {
    // WHY THE FUCK DID THIS NOT WORK
    // try {
    //   List<String> signInMethods =
    //       await _firebaseAuth.fetchSignInMethodsForEmail(email);
    //   print(signInMethods);
    //   print(email);
    //   return signInMethods.isNotEmpty;
    // } catch (error) {
    //   throw Exception(error.toString());
    // }

    // GOING WITH THIS INSTEAD BUT WHAT THE FUCK
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // update user
  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.userId)
          .update(user.toMap());
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // delete account
  Future<void> deleteAccount(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.userId).delete();
      await _firebaseAuth.currentUser!.delete();
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // change password
  Future<void> changePassword(String newPassword) async {
    try {
      await _firebaseAuth.currentUser!.updatePassword(newPassword);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}
