import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:development/data/networks/auth_network.dart';

class AuthRepository {
  final AuthNetwork _authNetwork = AuthNetwork();

  // Stream<User?> userStateChangeStream() {
  //   return _authNetwork.userAuthChangeStream;
  // }

  // get current user
  Future<UserModel> getCurrentUser(User user) {
    return _authNetwork.getCurrentUser(user);
  }

  // email password login
  Future<UserModel> emailPasswordSignIn(String email, String password) async {
    return await _authNetwork.emailPasswordSignIn(email, password);
  }

  // send otp email
  Future<Map<String, dynamic>> sendOtpEmail(String email, String name) async {
    return await _authNetwork.sendOtpEmail(email, name);
  }

  // verify otp
  bool verifyOtp(String userInput, String otp) {
    return _authNetwork.verifyOtp(userInput, otp);
  }

  // send onboarding email
  Future<Map<String, dynamic>> sendOnboardingEmail(
      String email, String name) async {
    return await _authNetwork.sendOnboardingEmail(email, name);
  }

  // check if user exists
  Future<bool> checkIfUserExists(String email) async {
    return await _authNetwork.checkIfUserExists(email);
  }

  // email password sign up
  Future<UserModel> emailPasswordSignUp(
      String name, String email, String password) async {
    return await _authNetwork.emailPasswordSignUp(name, email, password);
  }

  // sign out
  void signOut() async {
    await _authNetwork.signOut();
  }
}
