import 'package:chat_app_bloc/cubits/auth_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  // @override
  // void onChange(Change<AuthStates> change) {
  //   super.onChange(change);
  //   print(change);
  // }

  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(
            errorMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }

  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(LoginFailure(errorMessage: 'Your Email is already used'));
      } else if (e.code == 'weak-password') {
        emit(LoginFailure(
            errorMessage: 'Password Should be at least 6 characters'));
      }
    } catch (e) {
      emit(LoginFailure(errorMessage: 'Something went wrong'));
    }
  }
}
