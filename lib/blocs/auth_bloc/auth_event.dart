part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  String email, password;
  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {}
