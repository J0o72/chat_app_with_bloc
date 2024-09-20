abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class LoginLoading extends AuthStates {}

class LoginSuccess extends AuthStates {
  String email, password;

  LoginSuccess({required this.email, required this.password});
}

class LoginFailure extends AuthStates {
  String errorMessage;
  LoginFailure({required this.errorMessage});
}

class RegisterLoading extends AuthStates {}

class RegisterSuccess extends AuthStates {}

class RegisterFailure extends AuthStates {
  String errorMessage;
  RegisterFailure({required this.errorMessage});
}
