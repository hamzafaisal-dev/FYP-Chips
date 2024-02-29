import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/my_flutter_app_icons.dart';
import 'package:development/presentation/widgets/custom_dialog.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
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
    // "are you sure" alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          dialogTitle: 'Are you sure?',
          dialogContent: 'Do you want to log out?',
          buttonOneText: 'Cancel',
          buttonTwoText: 'Log Out',
          buttonOneOnPressed: () => Navigator.pop(context),
          buttonTwoOnPressed: () {
            BlocProvider.of<AuthBloc>(context).add(
              SignOutRequestedEvent(),
            );
          },
        );
      },
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
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,

        // back button
        leadingWidth: 64.w,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomIconButton(
              iconSvgPath: AssetPaths.leftArrowIconPath,
              iconWidth: 16.w,
              iconHeight: 16.h,
              onTap: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                padding: EdgeInsets.only(top: 5.h, bottom: 9.h),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            //
                            CircleAvatar(radius: 30.r),

                            //
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // name
                                  Text(
                                    _authenticatedUser?.userName ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),

                                  // email
                                  Text(
                                    _authenticatedUser?.email ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer
                                              .withOpacity(0.5),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                      Divider(
                        thickness: 1,
                        height: 0.h,
                      ),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //
                          UserStatSection(
                            statisticName: 'Posted Chips',
                            statisticValue:
                                _authenticatedUser?.postedChips.length ?? 0,
                          ),

                          // divider
                          SizedBox(
                            height: 70.73.h,
                            child: VerticalDivider(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              thickness: 1,
                              width: 0,
                            ),
                          ),

                          UserStatSection(
                            statisticName: 'Saved Chips',
                            statisticValue:
                                _authenticatedUser?.favoritedChips.length ?? 0,
                          ),
                        ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statisticName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.5),
                  ),
            ),
            Text(
              statisticValue.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),

        Padding(
          padding: EdgeInsets.only(left: 25.w),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Icon(
              CustomIcons.feedbackicon,
              color: Theme.of(context).colorScheme.primary,
              size: 18.dg,
            ),
          ),
        ),
      ],
    );
  }
}
