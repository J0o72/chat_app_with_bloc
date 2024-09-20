import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthStatesWithBloc> {
  // @override
  // void onTransition(Transition<AuthEvent, AuthStatesWithBloc> transition) {
  //   super.onTransition(transition);
  //   print(transition);
  // }

  AuthBloc() : super(AuthBlocInitial()) {
    on<AuthEvent>(
      (event, emit) {
        if (event is LoginEvent) {
          emit(LoginLoadingWithBloc());
          try {
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: event.email, password: event.password);
            emit(LoginSuccessWithBloc(
                email: event.email, password: event.password));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              emit(LoginFailureWithBloc(
                  errorMessage: 'No user found for that email.'));
            } else if (e.code == 'wrong-password') {
              emit(LoginFailureWithBloc(
                  errorMessage: 'Wrong password provided for that user.'));
            }
          } catch (e) {
            emit(LoginFailureWithBloc(errorMessage: 'Something went wrong'));
          }
        }
      },
    );
  }
}
