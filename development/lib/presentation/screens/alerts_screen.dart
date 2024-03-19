import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  late final List<NotificationModel> _notifications;

  @override
  void initState() {
    if (widget.arguments != null) {
      _notifications = widget.arguments!["notifications"];
    }

    print('_notifications are $_notifications');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
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
        padding: const EdgeInsets.only(top: 6),
        child: (_notifications.isEmpty)
            ? const Center(child: Text('Such empty, much wow'))
            : ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  NotificationModel notification = _notifications[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: ListTile(
                      tileColor: Theme.of(context).colorScheme.surface,
                      leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Icon(
                          Icons.bookmark,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      title: Text(notification.message),
                      subtitle: Text(
                        Helpers.formatTimeAgo(
                          notification.timestamp.toString(),
                        ),
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
