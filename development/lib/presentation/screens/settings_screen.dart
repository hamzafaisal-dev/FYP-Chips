import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_dialog.dart';
import 'package:development/presentation/widgets/settings_action_tile.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
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
  late final UserModel? _authenticatedUser;

  @override
  void initState() {
    super.initState();
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;
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
                // background
                Container(
                  height: 146.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: SvgPicture.asset(
                        AssetPaths.settingsScreenBannerPath,
                        width: 133.w,
                        height: 129.69.h,
                      ),
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

                        // email
                        Text(
                          _authenticatedUser?.email ?? 'No email found',
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
                                NavigationService.routeToNamed("/user_profile"),
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

            // Favorited Chips
            SettingsActionTile(
              title: 'Favorited Chips',
              subTitle: 'View your favorited chips',
              leadingIcon: SvgPicture.asset(
                AssetPaths.notificationBellIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
              onTap: () => NavigationService.routeToNamed('/favorite-chip'),
            ),

            SizedBox(height: 8.h),

            // Applied Chips
            SettingsActionTile(
              title: 'Applied Chips',
              subTitle: 'View your applied chips',
              leadingIcon: SvgPicture.asset(
                AssetPaths.moreIconPath,
                width: 18.w,
                height: 3.63.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
              onTap: () => NavigationService.routeToNamed('/applied-chip'),
            ),

            SizedBox(height: 16.h),

            // 'Other'
            Text(
              'Other',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            SizedBox(height: 20.h),

            // 'Contact Us'
            SettingsActionTile(
              title: 'Contact Us',
              leadingIcon: SvgPicture.asset(
                AssetPaths.contactIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
              onTap: () {
                HelperWidgets.showSnackbar(
                  context,
                  "Feature under development... thank you for your patience!😄",
                  "info",
                );
              },
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
              onTap: () {
                HelperWidgets.showSnackbar(
                  context,
                  "Drafting privacy policy... thank you for your patience!😄",
                  "info",
                );
              },
            ),

            SizedBox(height: 8.h),

            // 'About Us'
            SettingsActionTile(
              title: 'About Us',
              leadingIcon: SvgPicture.asset(
                AssetPaths.feedbackIconPath,
                width: 18.w,
                height: 18.h,
              ),
              trailingIcon: Icons.arrow_forward_ios_rounded,
              onTap: () => NavigationService.routeToNamed('/about-us'),
            ),

            SizedBox(height: 8.h),

            // 'Sign out'
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthInitial) {
                  Navigator.pop(context);
                  NavigationService.routeToReplacementNamed('/login');
                  HelperWidgets.showSnackbar(
                    context,
                    "Signed out successfully!👋",
                    "success",
                  );
                }
              },
              builder: (context, state) {
                return SettingsActionTile(
                  title: 'Sign out',
                  leadingIcon: SvgPicture.asset(
                    AssetPaths.aboutIconPath,
                    width: 16.w,
                    height: 16.h,
                  ),
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return CustomDialog(
                          dialogTitle: 'Are you sure?',
                          dialogContent: 'Do you want to sign out?',
                          buttonOneText: 'Cancel',
                          buttonTwoText: 'Sign Out',
                          buttonOneOnPressed: () => Navigator.pop(context),
                          buttonTwoOnPressed: () {
                            BlocProvider.of<AuthCubit>(context).signOut();
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    ));
  }
}
