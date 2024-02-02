import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:development/data/networks/auth_network.dart';

class AuthRepository {
  UserFirebaseClient userFirebaseClient;

  AuthRepository({required this.userFirebaseClient});

  Stream<User?> userStateChangeStream() {
    return userFirebaseClient.userAuthChangeStream;
  }

  Future<UserModel?> getCurrentUser(User? user) {
    return userFirebaseClient.getCurrentUser(user);
  }

  Future<UserModel> handleLogin(String email, String password) async {
    return await userFirebaseClient.handleLogin(email, password);
  }

  Future<UserModel> handleSignUp(
      String name, String email, String password) async {
    return await userFirebaseClient.handleSignUp(name, email, password);
  }

  void signOut() async {
    await userFirebaseClient.signOut();
  }
}
