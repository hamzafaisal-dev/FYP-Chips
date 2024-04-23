import 'package:development/business%20logic/cubits/notification/notification_cubit.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final NotificationModel notification;

  IconData _generateIcon(String notificationMessage) {
    if (notificationMessage.contains('saved')) {
      return Icons.bookmark;
    } else if (notificationMessage.contains('liked')) {
      return Icons.thumb_up_rounded;
    } else if (notificationMessage.contains('commented')) {
      return Icons.comment;
    } else {
      return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: ListTile(
          //
          tileColor: notification.read
              ? Theme.of(context).colorScheme.surface
              : Colors.grey.withOpacity(0.4), //Color(0XFFDCEDFD)

          leading: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Icon(
              _generateIcon(notification.message),
              color: Theme.of(context).colorScheme.onSecondary,
              size: 22,
            ),
          ),
          title: Text(notification.message),
          subtitle: Text(
            Helpers.formatTimeAgo(
              notification.timestamp.toString(),
            ),
          ),
          onTap: () {
            BlocProvider.of<NotificationCubit>(context)
                .notificationViewedEvent(notification);

            NavigationService.routeToNamed(
              '/view-chip',
              arguments: {"chipId": notification.jobId},
            );
          }),
    );
  }
}
