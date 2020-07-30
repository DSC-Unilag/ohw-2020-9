part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeThemeEvent extends ThemeEvent {
  @override
  List<Object> get props => [];
}

class GetThemeEvent extends ThemeEvent {
  @override
  List<Object> get props => [];
}
