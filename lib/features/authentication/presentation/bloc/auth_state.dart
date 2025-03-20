part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  UserRole? get role => null;
  UserModel? get user => null;

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel _user;
  final UserRole _role;

  AuthSuccess(UserModel user)
      : _user = user,
        _role = UserRole.fromString(user.role);

  @override
  UserModel? get user => _user;

  @override
  UserRole? get role => _role;

  @override
  List<Object> get props => [_user, _role];
}

class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class UserInfoDone extends AuthState {}
