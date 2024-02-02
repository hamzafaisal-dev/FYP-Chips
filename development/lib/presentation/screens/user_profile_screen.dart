import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserModel? _authenticatedUser;

  @override
  void initState() {
    final authBlocBloc = BlocProvider.of<AuthBloc>(context);
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    final signInBloc = BlocProvider.of<SignInBloc>(context);

    if (authBlocBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBlocBloc.state as AuthStateAuthenticated).authenticatedUser;
    } else if (signUpBloc.state is SignUpValidState) {
      _authenticatedUser = (signUpBloc.state as SignUpValidState).newUser;
    } else if (signInBloc.state is SignInValidState) {
      _authenticatedUser =
          (signInBloc.state as SignInValidState).authenticatedUser;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(_authenticatedUser?.userName ?? 'a.u'),
          ),
        ],
      ),
    );
  }
}
