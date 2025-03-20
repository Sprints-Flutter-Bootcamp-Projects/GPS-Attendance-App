part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String fullName;

  SignUpRequested(
      {required this.email, required this.password, required this.fullName});

  @override
  List<Object> get props => [email, password];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RestoreAuthRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}
