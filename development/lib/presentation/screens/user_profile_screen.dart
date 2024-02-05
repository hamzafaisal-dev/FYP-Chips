import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserModel? _authenticatedUser;

  void logOut() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.9,
                    child: FilledButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          SignOutRequestedEvent(),
                        );
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.9,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'No',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateAuthenticated) {
            print(state.authenticatedUser.userName);
          }

          if (state is AuthError) {
            NavigationService.routeToReplacementNamed('/login');
          }

          if (state is AuthStateUnauthenticated) {
            NavigationService.routeToReplacementNamed('/login');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            Center(
              child: Text(_authenticatedUser?.userName ?? 'a.u'),
            ),

            FilledButton(
              onPressed: () => NavigationService.routeToNamed('/home'),
              child: const Text('hOME'),
            ),

            FilledButton(
              onPressed: () => NavigationService.routeToNamed('/add-chip'),
              child: const Text('add chip'),
            ),

            FilledButton(
              onPressed: logOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
