import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/presentation/widgets/notification_tile.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late final List<NotificationModel> _notifications;
  late final UserModel? _authenticatedUser;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) {
      _authenticatedUser = authState.user;
      Helpers.logEvent(
        _authenticatedUser!.userId,
        "check-notificaitons",
        [_authenticatedUser],
      );
    }

    if (widget.arguments != null) {
      _notifications = widget.arguments!["notifications"];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,

        // back button
        leadingWidth: 64.w,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomIconButton(
              iconSvgPath: AssetPaths.leftArrowIconPath,
              iconWidth: 16.w,
              iconHeight: 16.h,
              onTap: () => NavigationService.goBack(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
        child: (_notifications.isEmpty)
            ? Center(
                child: Column(
                  children: [
                    //
                    Padding(
                      padding: EdgeInsets.only(top: 81.h),
                      child: Lottie.asset(
                        AssetPaths.manPeekingAnimationPath,
                        frameRate: FrameRate.max,
                        width: 279.w,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Text(
                        "You don't have any notifications yet.",
                        style: Theme.of(context).textTheme.labelSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  NotificationModel notification = _notifications[index];

                  return NotificationTile(notification: notification);
                },
              ),
      ),
    );
  }
}
