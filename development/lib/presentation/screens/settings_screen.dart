import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/settings_action_tile.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late UserModel? _authenticatedUser;

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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 8.1.h),

            // check your profile banner
            Stack(
              children: [
                // background image
                Container(
                  height: 146.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                    image: const DecorationImage(
                      image: AssetImage(AssetPaths.homeScreenBannerPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // column containing the text and button
                Positioned(
                  top: 20.0.h,
                  left: 33.0.w,
                  child: SizedBox(
                    width: 234.w,
                    height: 106.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // check your profile text
                        Text(
                          "Check Your Profile",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0.sp,
                                  ),
                        ),

                        // SizedBox(height: 4.h),

                        // email
                        Text(
                          _authenticatedUser?.email ?? '',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.5),
                                  ),
                        ),

                        const Spacer(),

                        // view button
                        SizedBox(
                          height: 40.h,
                          width: 120.w,
                          child: FilledButton(
                            onPressed: () =>
                                NavigationService.routeToNamed('/profile'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                            ),
                            child: Text(
                              'View',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 17.h),

            // 'General'
            Text(
              'General',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: 20.h),

            // 'Notifications'
            SettingsActionTile(
              title: 'Notifications',
              subTitle: 'Customize notifications',
              leadingIcon: SvgPicture.asset(
                AssetPaths.notificationBellIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'More customization'
            SettingsActionTile(
              title: 'More customization',
              subTitle: 'Customize more',
              leadingIcon: SvgPicture.asset(
                AssetPaths.moreIconPath,
                width: 18.w,
                height: 3.63.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 16.h),

            // 'Support'
            Text(
              'Support',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: 20.h),

            // 'Contact'
            SettingsActionTile(
              title: 'Contact',
              leadingIcon: SvgPicture.asset(
                AssetPaths.contactIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'Feedback'
            SettingsActionTile(
              title: 'Feedback',
              leadingIcon: SvgPicture.asset(
                AssetPaths.feedbackIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'Privacy Policy'
            SettingsActionTile(
              title: 'Privacy Policy',
              leadingIcon: SvgPicture.asset(
                AssetPaths.privacyPolicyIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'About'
            SettingsActionTile(
              title: 'About',
              leadingIcon: SvgPicture.asset(
                AssetPaths.aboutIconPath,
                width: 16.w,
                height: 16.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    ));
  }
}
