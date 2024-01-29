import 'package:development/presentation/screens/login_screen.dart';
import 'package:development/route_generator.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      onGenerateRoute: RouteGenerator.generateRoutes,
      navigatorKey: NavigationService.navigatorKey,
      home: const LoginScreen(),
    );
  }
}
