import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/my_flutter_app_icons.dart';
import 'package:development/presentation/widgets/settings_action_tile.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void logOut() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              const Text(
                'Are you sure you want to log out?',
                style: TextStyle(fontSize: 18),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateUnauthenticated) {
              NavigationService.routeToReplacementNamed('/login');
            }
          },
          child: Column(
            children: [
              //
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Container(
                  //
                  height: 260,

                  width: MediaQuery.of(context).size.width,

                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    // image: const DecorationImage(
                    //   image: AssetImage('assets/images/home_banner.png'),
                    //   fit: BoxFit.cover,
                    // ),
                  ),

                  child: Column(
                    children: [
                      //
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            //
                            const CircleAvatar(
                              radius: 30,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //
                                  const Text(
                                    'Marilyn Aminoff',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    'm.aminoff.22971@khi.iba.edu.pk',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Divider(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        thickness: 2,
                        height: 0,
                      ),

                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          const Expanded(
                            child: UserStatSection(
                              statisticName: 'Total Work Hours',
                              statisticValue: 18,
                            ),
                          ),

                          SizedBox(
                            height: 85, // change ye value for responsiveness
                            child: VerticalDivider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              thickness: 2,
                              width: 0,
                            ),
                          ),

                          const Expanded(
                            child: UserStatSection(
                              statisticName: 'Task Completed',
                              statisticValue: 12,
                            ),
                          ),
                        ],
                      ),

                      Divider(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        thickness: 2,
                        height: 0,
                      ),
                    ],
                  ),
                ),
              ),

              SettingsActionTile(
                title: 'Sign Out',
                leadingIcon: CustomIcons.logout,
                trailingIcon: Icons.arrow_forward_ios_rounded,
                onTap: logOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserStatSection extends StatelessWidget {
  const UserStatSection({
    super.key,
    required this.statisticName,
    required this.statisticValue,
  });

  final String statisticName;
  final int statisticValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text(
                statisticName,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),

              Text(
                statisticValue.toString(),
                style: Theme.of(context).textTheme.headlineMedium,

                // style: const TextStyle(
                //   fontSize: 24,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
            ],
          ),

          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Icon(
              CustomIcons.feedbackicon,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
