import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopContributorCard extends StatelessWidget {
  const TopContributorCard({
    super.key,
    required Map<String, dynamic> topContributor,
  }) : _topContributor = topContributor;

  final Map<String, dynamic> _topContributor;

  @override
  Widget build(BuildContext context) {
    String postedBy = _topContributor['postedBy'];
    String profilePictureUrl = _topContributor['profilePictureUrl'];
    int contributionsCount = _topContributor['postCount'];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.surface,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.4, 0.36],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // avatar
                Container(
                  padding: EdgeInsets.fromLTRB(35.w, 0.h, 35.w, 0.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 6),
                  ),
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: ClipOval(
                      child: SvgPicture.network(
                        profilePictureUrl,
                        height: double.maxFinite,
                        width: double.maxFinite,
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // name
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Text(
                    postedBy,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),

                // contribution count
                Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Text(
                    '$contributionsCount chips posted',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopContributorCardAlt extends StatelessWidget {
  const TopContributorCardAlt({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: InkWell(
        onTap: () => NavigationService.routeToNamed('/add-chip1'),
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // avatar
                Padding(
                  padding: EdgeInsets.fromLTRB(44.w, 9.h, 44.w, 9.h),
                  child: CircleAvatar(
                    radius: 40.r,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const ClipOval(
                      child: Icon(Icons.add, size: 50, color: Colors.white),
                    ),
                  ),
                ),

                Container(
                  // color: Colors.red,
                  child: Text(
                    'Become A\nTop Contributor',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
