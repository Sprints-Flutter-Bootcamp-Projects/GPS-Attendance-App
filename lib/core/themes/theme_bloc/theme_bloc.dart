import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeBloc({required this.lightTheme, required this.darkTheme}) : super(LightThemeState()) {
    on<ToggleThemeEvent>((event, emit) {
      if (state is LightThemeState) {
        emit(DarkThemeState());
      } else {
        emit(LightThemeState());
      }
    });
  }

  ThemeData get themeData {
    if (state is LightThemeState) {
      return lightTheme;
    } else {
      return darkTheme;
    }
  }
}