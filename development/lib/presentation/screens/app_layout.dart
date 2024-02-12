import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/presentation/screens/add_chip_screen.dart';
import 'package:development/presentation/screens/error_screen.dart';
import 'package:development/presentation/screens/home_screen.dart';
import 'package:development/presentation/screens/user_profile_screen.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  // final ResourceRepository resourceRepository;

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ResourceRepository resourceRepository = widget.resourceRepository;

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
          widget = const AddChipScreen();
          break;
        case 2:
          widget = const UserProfileScreen();
          break;
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
          title = 'Home';
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
        automaticallyImplyLeading: false,
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      );
    }

    return Scaffold(
      appBar: getAppbar(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        showUnselectedLabels: true,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: getContent(currentIndex),
    );
  }
}
