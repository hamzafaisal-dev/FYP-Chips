import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatSection extends StatelessWidget {
  const UserStatSection({
    Key? key,
    required this.statisticName,
    required this.statisticValue,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  final String statisticName;
  final int statisticValue;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Widget for displaying statistic name and value
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying statistic value
            Text(
              statisticValue.toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            // Displaying statistic name
            Text(
              statisticName,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                        .withOpacity(0.5),
                  ),
            ),
          ],
        ),

        // Widget for displaying the icon
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
              icon,
              color: iconColor,
              size: 18.dg,
            ),
          ),
        ),
      ],
    );
  }
}
