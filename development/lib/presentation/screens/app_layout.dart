import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/notification/notification_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/custom_colors.dart';
import 'package:development/data/models/notification_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/screens/error_screen.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/settings_screen.dart';
import 'package:development/presentation/widgets/search_bar.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late final UserModel? _authenticatedUser;
  final _searchController = TextEditingController();

  int _currentIndex = 0;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;

    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    BlocProvider.of<NotificationCubit>(context)
        .fetchUserNotificationsStream(_authenticatedUser!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget getContent(index) {
      Widget widget = const ErrorScreen();
      switch (index) {
        case 0:
          widget = HomeScreen(searchController: _searchController);
          break;
        case 1:
          widget = const SettingsScreen();
          break;
        default:
          widget = const ErrorScreen();
          break;
      }
      return widget;
    }

    AppBar getAppbar() {
      String title;

      switch (_currentIndex) {
        case 0:
          title = 'Homepage';
        case 1:
          title = 'Settings';
        case 2:
          title = 'Profile';
        default:
          title = 'IBARA';
      }

      return AppBar(
        scrolledUnderElevation: 1,
        shadowColor: Colors.black,
        backgroundColor: CustomColors.weirdWhite,
        title: (_currentIndex == 0)
            ? CustomSearchBar(searchController: _searchController)
            : Text(title),
        automaticallyImplyLeading: false,

        //
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0.w),
            child: BlocConsumer<NotificationCubit, NotificationState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is NotificationsStreamLoaded) {
                  return StreamBuilder<List<NotificationModel>>(
                      stream: state.notifications,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<NotificationModel> notifications = snapshot.data!
                              .where((notif) => notif.read == false)
                              .toList();

                          return Badge.count(
                            count: notifications.length,
                            isLabelVisible: notifications.isNotEmpty,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => NavigationService.routeToNamed(
                                '/notifications',
                                arguments: {"notifications": snapshot.data},
                              ),
                              child: Transform.scale(
                                scale: 1.2,
                                child: SvgPicture.asset(
                                  AssetPaths.alertsIconPath,
                                  width: 18.42.w,
                                  height: 21.67.h,
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.onPrimary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      });
                }

                return const Text('notifs laoding');
              },
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: getAppbar(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          getContent(0),
          getContent(1),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 64.h,
        child: BottomNavigationBar(
          elevation: 5,
          backgroundColor: Theme.of(context).colorScheme.surface,
          onTap: (int index) {
            setState(() => _currentIndex = index);
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Transform.scale(
                scale: 1.1,
                child: const Icon(CupertinoIcons.home),
              ),
              label: 'Home',
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // log event
          Helpers.logEvent(
            _authenticatedUser!.userId,
            "press-add-chip-button",
            [_authenticatedUser],
          );

          NavigationService.routeToNamed('/add-chip1');
        },
        elevation: 0,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                spreadRadius: 22,
              ),
            ],
          ),
          child: Transform.scale(
            scale: 1.4,
            child: const Icon(Icons.add),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
