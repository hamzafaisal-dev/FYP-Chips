import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/presentation/screens/error_screen.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/user_profile_screen.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;
  final _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // shows dynamic screen content based on btotom navbar index
    Widget getContent(index) {
      Widget widget = const ErrorScreen();
      switch (index) {
        case 0:
          widget = BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthStateUnauthenticated) {
                NavigationService.routeToReplacementNamed('/login');
              }
            },
            child: const HomeScreen(),
          );
          break;
        case 1:
          widget = const UserProfileScreen();
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
          title = 'Add';
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
        // automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,

        leading: Padding(
          padding: const EdgeInsets.only(top: 5, left: 15),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            radius: 0,
            child: Icon(
              Icons.menu,
              color: Theme.of(context).colorScheme.onSecondary,
              size: 22,
            ),
          ),
        ),

        leadingWidth: 60,

        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: AnimSearchBar(
              color: Theme.of(context).colorScheme.secondary,
              width: MediaQuery.of(context).size.width / 1.8,
              boxShadow: false,
              textController: _searchBarController,
              onSuffixTap: () {},
              onSubmitted: (value) {},
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 18),
          //   child: CircleAvatar(
          //     backgroundImage: NetworkImage(
          //       'https://preview.redd.it/is-there-a-lore-reason-why-kid-named-finger-is-voicing-v0-bj5zipugk4fb1.jpg?width=640&crop=smart&auto=webp&s=0efa1df13a414ee1611c067e6a0631d6f0af1e9d',
          //     ),
          //   ),
          // ),
        ],
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
                label: 'Home'),
            // BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
            BottomNavigationBarItem(
                icon: Transform.scale(
                  scale: 1.1,
                  child: const Icon(CupertinoIcons.settings),
                ),
                label: 'Settings'),
          ],
        ),
      ),

      body: getContent(currentIndex),

      floatingActionButton: FloatingActionButton(
        onPressed: () => NavigationService.routeToNamed('/add-chip'),
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
