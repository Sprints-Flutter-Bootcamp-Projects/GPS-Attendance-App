part of 'user_profile_cubit.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserModel user;
  final String workZone;

  const UserProfileLoaded({required this.user, required this.workZone});
}

class UserProfileError extends UserProfileState {
  final String errorMessage;

  const UserProfileError({required this.errorMessage});
}

class UserProfileUserNotAuthenticated extends UserProfileState {}
