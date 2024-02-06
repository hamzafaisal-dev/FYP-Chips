import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirebaseClient {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  UserFirebaseClient({required this.firebaseAuth, required this.firestore});

  Stream<User?> get userAuthChangeStream => firebaseAuth.userChanges();

  // get current user
  Future<UserModel?> getCurrentUser(User? currentUser) async {
    String? currentUserId = currentUser?.uid;

    if (currentUserId == null) return null;

    DocumentSnapshot querySnapshot =
        await firestore.collection('users').doc(currentUserId).get();

    Map<String, dynamic> userMap = querySnapshot.data() as Map<String, dynamic>;

    UserModel user = UserModel.fromMap(userMap);

    return user;
  }

  // email and pass login
  Future<UserModel> handleLogin(String email, String password) async {
    // print('email is $email');
    // print('pass is $password');

    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot userSnapshot = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      UserModel authenticatedUser =
          UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);

      print(authenticatedUser);

      return authenticatedUser;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  // email and pass sign up
  Future<UserModel> handleSignUp(
      String name, String email, String password) async {
    final newUserCredentials =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userId = newUserCredentials.user!.uid;

    UserModel newUser = UserModel(
      userId: userId,
      role: 'user',
      email: email,
      userName: name,
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
    await firebaseAuth.signOut();
  }
}
