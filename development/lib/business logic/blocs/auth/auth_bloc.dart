// import 'package:bloc/bloc.dart';
// import 'package:development/data/models/user_model.dart';
// import 'package:development/data/repositories/auth_repository.dart';
// import 'package:equatable/equatable.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository authRepository;

//   AuthBloc({required this.authRepository}) : super(AuthStatusUnknown()) {
//     //
//     authRepository.userStateChangeStream().listen((user) async {
//       UserModel? currentUser = await authRepository.getCurrentUser(user);

//       if (currentUser == null) return;

//       add(AuthStateChangedEvent(currentUser));
//     });

//     on<AuthStateChangedEvent>((event, emit) {
//       event.user != null
//           ? emit(AuthStateAuthenticated(event.user!))
//           : emit(AuthStateUnauthenticated());
//     });

//     on<AuthStateUpdatedEvent>((event, emit) {
//       emit(AuthStateAuthenticated(event.user!));
//     });

//     on<SignOutRequestedEvent>((event, emit) {
//       try {
//         emit(SigningOutState());

//         authRepository.signOut();

//         emit(AuthStateUnauthenticated());
//       } catch (error) {
//         emit(AuthError(error.toString()));
//       }
//     });
//   }
// }
