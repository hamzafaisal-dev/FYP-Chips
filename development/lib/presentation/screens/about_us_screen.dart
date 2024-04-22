import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';

import '../widgets/team_member_tile.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // rounded image
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.81,
                    height: MediaQuery.sizeOf(context).width * 0.81,
                    margin: EdgeInsets.all(9.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999.w),
                      child: Image.asset(
                        AssetPaths.aboutUsScreenBannerPath,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // team name text
                  Text(
                    'Power of Friendship🤨',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  // team description text
                  Text(
                    "Introducing Team POF, where camaraderie reigns supreme! Just like the legendary 2021/22 Champions League-winning Real Madrid squad, we believe in the extraordinary power of teamwork, unity, and unwavering spirit.\n\nWe embrace the notion that success isn't just about individual talent, but the magic that happens when a group comes together as one. Our mobile app embodies this ethos, aiming to foster meaningful relationships, and empower users to achieve their goals by connecting people with one another.\n\nJoin us on this journey, where every connection made is a testament to the boundless potential of collaboration!",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 18.h),

                  // team members text
                  Text(
                    'Team Members',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  // team members list
                  const Column(
                    children: [
                      // member 1
                      TeamMemberTile(
                        title: "Hamza Faisal (Tech Lead)",
                        subtitle: "Developer",
                        imagePath: AssetPaths.hamza,
                        username: 'hamza-faisal-dev',
                      ),

                      // member 2
                      TeamMemberTile(
                        title: "Hassan Nami",
                        subtitle: "ML Engineer",
                        imagePath: AssetPaths.hassan,
                        username: 'muhammad-hassan-nami',
                      ),

                      // member 3
                      TeamMemberTile(
                        title: "Muhammad Aun (Team Lead)",
                        subtitle: "Developer",
                        imagePath: AssetPaths.aun,
                        username: 'ayekaunic',
                      ),

                      // member 4
                      TeamMemberTile(
                        title: "Umar Khalid",
                        subtitle: "UI/UX Designer",
                        imagePath: AssetPaths.umar,
                        username: 'umar-khalid-299767218',
                      ),

                      // member 5
                      TeamMemberTile(
                        title: "Younas Mahmood",
                        subtitle: "ML Engineer",
                        imagePath: AssetPaths.younas,
                        username: 'younas-mahmood',
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
