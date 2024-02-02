import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/data/networks/auth_network.dart';
import 'package:development/data/repositories/auth_repository.dart';
import 'package:development/firebase_options.dart';
import 'package:development/presentation/screens/login_screen.dart';
import 'package:development/route_generator.dart';
import 'package:development/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final AuthRepository authRepository = AuthRepository(
    userFirebaseClient: UserFirebaseClient(
      firebaseAuth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
    ),
  );

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authRepository});

  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (context) => SignInBloc(authRepository: authRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.generateRoutes,
        navigatorKey: NavigationService.navigatorKey,
        home: const LoginScreen(),
      ),
    );
  }
}
