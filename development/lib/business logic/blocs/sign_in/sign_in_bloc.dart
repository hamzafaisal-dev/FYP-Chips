import 'package:bloc/bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/auth_repository.dart';
import 'package:development/utils/firebase_helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({required this.authRepository}) : super(SignInInitialState()) {
    on<SignInSubmittedEvent>((event, emit) async {
      await _signInWithMailAndPass(emit, event.email, event.password);
    });
  }

  Future<void> _signInWithMailAndPass(
    Emitter<SignInState> emit,
    String email,
    String password,
  ) async {
    emit(SignInLoadingState());
    try {
      // get user credential from login operation
      UserModel authenticatedUser =
          await authRepository.handleLogin(email, password);

      //  emit valid login state
      emit(SignInValidState(authenticatedUser));
    } on FirebaseAuthException catch (error) {
      // get error statement from util and emit it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignInInErrorState(firebaseAuthError));
    } catch (e) {
      emit(SignInInErrorState(e.toString()));
    }
  }
}
