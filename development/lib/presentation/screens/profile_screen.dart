import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/my_flutter_app_icons.dart';
import 'package:development/presentation/widgets/custom_dialog.dart';
import 'package:development/presentation/widgets/settings_action_tile.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel? _authenticatedUser;

  void _logOut() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: CustomDialog(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(
              SignOutRequestedEvent(),
            );
          },
          dialogTitle: 'Are you sure you want to log out?',
          buttonOneText: 'Yes',
          buttonTwoText: 'No',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }
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
                                  Text(
                                    _authenticatedUser?.userName ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    _authenticatedUser?.email ?? '',
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
                          Expanded(
                            child: UserStatSection(
                              statisticName: 'Posted Chips',
                              statisticValue:
                                  _authenticatedUser?.postedChips.length ?? 0,
                            ),
                          ),

                          SizedBox(
                            height: 85, // change ye value if shit looks off
                            child: VerticalDivider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              thickness: 2,
                              width: 0,
                            ),
                          ),

                          Expanded(
                            child: UserStatSection(
                              statisticName: 'Saved Chips',
                              statisticValue:
                                  _authenticatedUser?.favoritedChips.length ??
                                      0,
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
                leadingIcon: SvgPicture.asset(
                  // this icon will change later on
                  AssetPaths.notificationBellIconPath,
                  width: 18.w,
                  height: 18.h,
                ),
                trailingIcon: Icons.arrow_forward_ios_rounded,
                onTap: _logOut,
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
