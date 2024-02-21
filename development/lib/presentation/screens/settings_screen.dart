import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/my_flutter_app_icons.dart';
import 'package:development/presentation/widgets/general_settings_action_tile%20copy.dart';
import 'package:development/presentation/widgets/support_settings_action_tile.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            SizedBox(height: 20.h),

            // check your profile banner
            Stack(
              children: [
                // background image
                Container(
                  height: 146.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/home_banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // column containing the text and button
                Positioned(
                  top: 20.0.h,
                  left: 33.0.w,
                  child: SizedBox(
                    width: 180.w,
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

                        SizedBox(height: 4.h),

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

                        SizedBox(height: 22.h),

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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
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
            const GeneralSettingsActionTile(
              title: 'Notifications',
              subTitle: 'Customize notifications',
              leadingIcon: CustomIcons.notificationsicon,
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'More customization'
            const GeneralSettingsActionTile(
              title: 'More customization',
              subTitle: 'Customize it more to fit to your usage',
              leadingIcon: Icons.more_horiz,
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
            const SupportSettingsActionTile(
              title: 'Contact',
              leadingIcon: CustomIcons.contacticon,
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'Feedback'
            const SupportSettingsActionTile(
              title: 'Feedback',
              leadingIcon: CustomIcons.feedbackicon,
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'Privacy Policy'
            const SupportSettingsActionTile(
              title: 'Privacy Policy',
              leadingIcon: CustomIcons.privacypolicyicon,
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 8.h),

            // 'About'
            const SupportSettingsActionTile(
              title: 'About',
              leadingIcon: CustomIcons.abouticon,
              trailingIcon: Icons.arrow_forward_ios_rounded,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    ));
  }
}
