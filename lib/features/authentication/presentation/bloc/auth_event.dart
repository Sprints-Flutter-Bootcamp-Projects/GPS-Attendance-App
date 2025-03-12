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

class SaveUserDetailsEvent extends AuthEvent {
  final String company;
  final String department;
  final String title;
  final String? imageUrl;

  SaveUserDetailsEvent({
    required this.company,
    required this.department,
    required this.title,
    this.imageUrl,
  });
}
