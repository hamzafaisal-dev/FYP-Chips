import 'package:bloc/bloc.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/repositories/auth_repository.dart';
import 'package:development/utils/firebase_helpers.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({required this.authRepository}) : super(SignUpInitialState()) {
    on<SignUpSubmittedEvent>((event, emit) async {
      //
      await _signUpWithMailAndPass(
        event.name,
        event.email,
        event.password,
        emit,
      );
    });
  }

  Future<void> _signUpWithMailAndPass(
      String name, String email, String password, Emitter emit) async {
    //
    try {
      emit(SignUpLoadingState());

      UserModel newUser =
          await authRepository.handleSignUp(name, email, password);

      emit(SignUpValidState(newUser));
    } on FirebaseAuthException catch (error) {
      // get error statement from util and emit it
      String firebaseAuthError =
          FirebaseAuthExceptionErrors.getFirebaseError(error);

      emit(SignUpErrorState(firebaseAuthError));
    } catch (error) {
      emit(SignUpErrorState(error.toString()));
    }
  }
}
