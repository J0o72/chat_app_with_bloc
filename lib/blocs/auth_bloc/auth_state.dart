part of 'auth_bloc.dart';

abstract class AuthStatesWithBloc {}

final class AuthBlocInitial extends AuthStatesWithBloc {}

class LoginLoadingWithBloc extends AuthStatesWithBloc {}

class LoginSuccessWithBloc extends AuthStatesWithBloc {
  String email, password;

  LoginSuccessWithBloc({required this.email, required this.password});
}

class LoginFailureWithBloc extends AuthStatesWithBloc {
  String errorMessage;
  LoginFailureWithBloc({required this.errorMessage});
}

class RegisterLoadingWithBloc extends AuthStatesWithBloc {}

class RegisterSuccessWithBloc extends AuthStatesWithBloc {}

class RegisterFailureWithBloc extends AuthStatesWithBloc {
  String errorMessage;
  RegisterFailureWithBloc({required this.errorMessage});
}
