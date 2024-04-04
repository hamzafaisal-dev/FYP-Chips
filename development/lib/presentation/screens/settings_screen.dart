import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/contact_us/contact_us_cubit.dart';
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

import '../widgets/check_your_profile_banner.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final UserModel? _authenticatedUser;

  final _contactUsController = TextEditingController();

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
              CheckYourProfileBanner(authenticatedUser: _authenticatedUser),

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

              // 'Contact Us'
              BlocListener<ContactUsCubit, ContactUsState>(
                listener: (context, state) {
                  if (state is ContactUsSuccess) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Message sent successfully!🚀",
                      "success",
                    );
                  }
                  if (state is ContactUsFailure) {
                    HelperWidgets.showSnackbar(
                      context,
                      "Failed to send message!😔",
                      "error",
                    );
                  }
                },
                child: SettingsActionTile(
                  title: 'Contact Us',
                  leadingIcon: SvgPicture.asset(
                    AssetPaths.contactIconPath,
                    width: 18.w,
                    height: 18.h,
                  ),
                  trailingIcon: Icons.arrow_forward_ios_rounded,
                  onTap: () {
                    // show "send us a message" modal bottom sheet
                    handleContactUs(context);
                  },
                ),
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
                      handleSignOut(context);
                    },
                  );
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // sign out method
  Future<dynamic> handleSignOut(BuildContext context) {
    return showDialog(
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
  }

  // contact us method
  Future<dynamic> handleContactUs(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  'Contact Us',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 18.sp),
                ),

                SizedBox(height: 20.h),

                // message text field
                TextField(
                  controller: _contactUsController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Type your message here...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // send button
                SizedBox(
                  width: double.maxFinite,
                  height: 43.2.h,
                  child: BlocListener<ContactUsCubit, ContactUsState>(
                    listener: (context, state) {
                      if (state is ContactUsLoading) {
                        Navigator.pop(context);
                        HelperWidgets.showSnackbar(
                          context,
                          "Sending message...⏳",
                          "info",
                        );
                      }
                    },
                    child: FilledButton(
                      onPressed: () {
                        BlocProvider.of<ContactUsCubit>(context).contactUs(
                          _authenticatedUser?.username ?? '',
                          _contactUsController.text,
                        );
                        _contactUsController.clear();
                      },
                      child: const Text("Send"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
