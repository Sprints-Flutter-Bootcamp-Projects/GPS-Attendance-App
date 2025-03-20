import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance/core/models/user/user_role.dart';
import 'package:gps_attendance/core/models/user/user_model.dart';
import 'package:gps_attendance/features/authentication/data/repositories/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final SharedPreferences prefs;

  AuthBloc({required this.authService, required this.prefs})
      : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<LoginRequested>(_onLoginRequested);
    on<RestoreAuthRequested>(_onRestoreAuthRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authService.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      );
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Sign up failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authService.signIn(
        email: event.email,
        password: event.password,
      );
      await prefs.setString('current_user', user.toJson());
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRestoreAuthRequested(
    RestoreAuthRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userJson = prefs.getString('current_user');
      if (userJson != null) {
        final user = UserModel.fromJson(userJson);
        emit(AuthSuccess(user));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await prefs.remove('current_user');
    emit(AuthInitial());
  }
}
