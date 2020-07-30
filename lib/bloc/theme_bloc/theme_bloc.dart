import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ChangeThemeInitial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeThemeEvent) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String themeMode = prefs.getString('themeMode') ?? 'light';
      themeMode == 'light'
          ? prefs.setString('themeMode', 'dark')
          : prefs.setString('themeMode', 'light');
      if (themeMode == 'light') {
        prefs.setString('themeMode', 'dark');
        themeMode = 'dark';
      } else {
        prefs.setString('themeMode', 'light');
        themeMode = 'light';
      }

      yield ChangeThemeLoaded(themeMode);
    } else if (event is GetThemeEvent) {
      yield GetThemeLoading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String themeMode = prefs.getString('themeMode') ?? 'light';
      yield GetThemeLoaded(themeMode);
    }
  }
}
