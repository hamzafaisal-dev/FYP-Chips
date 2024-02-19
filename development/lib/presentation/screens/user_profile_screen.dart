import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/settings_action_tile.dart';
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
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: SafeArea(
        child: ListView(
          children: [
            //
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                  child: Container(
                    height: 146,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(18),
                      // image: const DecorationImage(
                      //   image: AssetImage('assets/images/home_banner.png'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 4),
                          child: Text(
                            "Check Your Profile",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            _authenticatedUser?.email ?? '',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(0.7),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width / 3,
                          child: FilledButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                            ),
                            child: const Text(
                              'View',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 'General'
            const Padding(
              padding: EdgeInsets.fromLTRB(4, 6, 4, 10),
              child: Text(
                'General',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // const SizedBox(height: 16),

            // 'Notifications'
            const SettingsActionTile(
              title: 'Notifications',
              subTitle: 'Customize notifications',
              leadingIcon: Icons.notifications,
              trailingIcon: Icons.arrow_forward_ios,
            ),

            // 'More customization'
            const SettingsActionTile(
              title: 'More customization',
              subTitle: 'Customize it more to fit to your usage',
              leadingIcon: Icons.more_horiz,
              trailingIcon: Icons.arrow_forward_ios,
            ),

            // 'Support'
            const Padding(
              padding: EdgeInsets.fromLTRB(4, 6, 4, 10),
              child: Text(
                'Support',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            // 'Contact'
            const SettingsActionTile(
              title: 'Contact',
              leadingIcon: Icons.notifications,
              trailingIcon: Icons.arrow_forward_ios,
            ),

            // 'Feedback'
            const SettingsActionTile(
              title: 'Feedback',
              leadingIcon: Icons.notifications,
              trailingIcon: Icons.arrow_forward_ios,
            ),

            // 'Privacy Policy'
            const SettingsActionTile(
              title: 'Privacy Policy',
              leadingIcon: Icons.notifications,
              trailingIcon: Icons.arrow_forward_ios,
            ),

            // 'About'
            const SettingsActionTile(
              title: 'About',
              leadingIcon: Icons.notifications,
              trailingIcon: Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    ));
  }
}
