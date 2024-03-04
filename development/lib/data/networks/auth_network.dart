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

  Stream<User?> get userAuthChangeStream => _firebaseAuth.userChanges();

  // get current user
  Future<UserModel?> getCurrentUser(User? currentUser) async {
    String? currentUserId = currentUser?.uid;

    if (currentUserId == null) return null;

    DocumentSnapshot querySnapshot =
        await _firestore.collection('users').doc(currentUserId).get();

    Map<String, dynamic> userMap = querySnapshot.data() as Map<String, dynamic>;

    UserModel user = UserModel.fromMap(userMap);

    return user;
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
  Future<Map<String, dynamic>> sendOtpEmail(
      String email, String name, String password) async {
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
          'name': name,
          'password': password,
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

    return newUser;
  }

  // sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // reset password
  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // update user
  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).update(user.toMap());
  }

  // delete user
  Future<void> deleteUser(UserModel user) async {
    await _firestore.collection('users').doc(user.userId).delete();
  }

  // change password
  Future<void> changePassword(String newPassword) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }
}
