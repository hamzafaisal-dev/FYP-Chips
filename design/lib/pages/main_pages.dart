import 'package:design/pages/applied_b.dart';
import 'package:design/pages/favorites_b.dart';
import 'package:design/pages/home_b.dart';
import 'package:design/pages/profile_b2.dart';
import 'package:design/responsiveness.dart';
import 'package:design/widgets/hamburger_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainPages extends StatefulWidget {
  const MainPages({super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int currentIndex = 0;

  // fab bool
  bool isScrolled = true;

  @override
  Widget build(BuildContext context) {
    // screen width
    final sw = Responsiveness.sw(context);

    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // appbar
      appBar: [
        // home
        null,
        // favorites
        null,
        // applied
        null,
        // profile
        AppBar(
          backgroundColor: Theme.of(context).cardColor,
          title: const Text(
            'a.jone.23031',
            // style: TextStyle(fontWeight: FontWeight.w500),
          ),
          surfaceTintColor: Colors.transparent,
          actions: [
            // hamburger menu
            IconButton(
              tooltip: 'Menu',
              onPressed: () {
                showModalBottomSheet(
                  showDragHandle: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(sw * 0.063),
                      topRight: Radius.circular(sw * 0.063),
                    ),
                  ),
                  context: context,
                  builder: (context) {
                    return const HamburgerMenu();
                  },
                );
              },
              icon: const Icon(
                Icons.menu_outlined,
              ),
            ),
          ],
        ),
      ][currentIndex],

      // body
      // body: const <Widget>[
      //   HomeBody(),
      //   FavoritesBody(),
      //   AppliedBody(),
      //   ProfileBody2(),
      // ][currentIndex],

      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              isScrolled = true;
            });
          } else if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              isScrolled = false;
            });
          }
          return true;
        },
        child: IndexedStack(
          index: currentIndex,
          children: const [
            HomeBody(),
            FavoritesBody(),
            AppliedBody(),
            ProfileBody2(),
          ],
        ),
      ),

      // navigation
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Applied',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),

      // fab
      floatingActionButton: FloatingActionButton.extended(
        isExtended: isScrolled,
        tooltip: 'Post a Chip',
        icon: const Icon(Icons.add),
        label: const Text('Add Chip'),
        onPressed: () {
          Navigator.pushNamed(context, '/addChipForm');
        },
      ),
    );
  }
}
