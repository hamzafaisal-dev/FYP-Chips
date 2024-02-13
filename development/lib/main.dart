import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/data/networks/auth_network.dart';
import 'package:development/data/networks/chip_network.dart';
import 'package:development/data/repositories/auth_repository.dart';
import 'package:development/data/repositories/chip_repository.dart';
import 'package:development/firebase_options.dart';
import 'package:development/presentation/screens/login_screen.dart';
import 'package:development/route_generator.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/themes/theme.dart';
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

  final ChipRepository chipRepository = ChipRepository(
    chipsFirestoreClient: ChipsFirestoreClient(
      firestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ),
  );

  runApp(MyApp(authRepository: authRepository, chipRepository: chipRepository));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.authRepository, required this.chipRepository});

  final AuthRepository authRepository;
  final ChipRepository chipRepository;

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
        BlocProvider(
          create: (context) => ChipBloc(
            chipRepository: chipRepository,
            authBloc: BlocProvider.of<AuthBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Chips',
        debugShowCheckedModeBanner: false,
        theme: CustomAppTheme.lightTheme,
        onGenerateRoute: RouteGenerator.generateRoutes,
        navigatorKey: NavigationService.navigatorKey,
        home: const LoginScreen(),
      ),
    );
  }
}
