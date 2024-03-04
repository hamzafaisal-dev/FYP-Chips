import 'package:development/constants/asset_paths.dart';
import 'package:development/presentation/screens/error_screen.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/settings_screen.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // shows dynamic screen content based on btotom navbar index
    Widget getContent(index) {
      Widget widget = const ErrorScreen();
      switch (index) {
        case 0:
          widget = const HomeScreen();
          break;
        case 1:
          widget = const SettingsScreen();
          break;
        // case 2:
        //   widget = const AddChipScreen();
        //   break;
        // case 3:
        //   widget = const UserProfileScreen();
        //   break;
        // case 4:
        //   widget = const UserScreen();
        // break;
        default:
          widget = const ErrorScreen();
          break;
      }
      return widget;
    }

    AppBar getAppbar() {
      String title;

      switch (currentIndex) {
        case 0:
          title = 'Homepage';
        case 1:
          title = 'Settings';
        case 2:
          title = 'Profile';
        // case 3:
        //   title = 'Saved';
        // case 4:
        //   title = 'Profile';
        default:
          title = 'IBARA';
      }

      return AppBar(
        title: Text(title),

        // leading
        leadingWidth: 64.w,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomIconButton(
              iconSvgPath: AssetPaths.hamburgerMenuIconPath,
              iconWidth: 44.w,
              iconHeight: 44.h,
              onTap: () {},
            ),
          ),
        ),
      );
    }

    return Scaffold(
      //
      appBar: getAppbar(),

      bottomNavigationBar: SizedBox(
        height: 64,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          onTap: (int index) {
            setState(() => currentIndex = index);
          },
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Transform.scale(
                scale: 1.1,
                child: const Icon(CupertinoIcons.home),
              ),
              label: 'Home',
            ),
            // BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add',),
            BottomNavigationBarItem(
              icon: Transform.scale(
                scale: 1.1,
                child: const Icon(CupertinoIcons.settings),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),

      body: getContent(currentIndex),

      floatingActionButton: FloatingActionButton(
        onPressed: () => NavigationService.routeToNamed('/add-chip1'),
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Transform.scale(
          scale: 1.4,
          child: const Icon(Icons.add),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
