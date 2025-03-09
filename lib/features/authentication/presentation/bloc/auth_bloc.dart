import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gps_attendance/features/authentication/data/repositories/auth_repo.dart';
import 'package:gps_attendance/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // final AuthRepository _authRepository;
  final AuthService _authService;

  AuthBloc(this._authService) : super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SaveUserDetailsEvent>(_onSaveUserDetails);
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authService.signUp(
        email: event.email,
        password: event.password,
        role: event.role,
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

  Future<void> _onSaveUserDetails(
      SaveUserDetailsEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authService.saveUserDetails(
        company: event.company,
        department: event.department,
        title: event.title,
        imageUrl: event.imageUrl,
      );
      emit(UserInfoDone());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
