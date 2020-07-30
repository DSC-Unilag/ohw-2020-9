part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ChangeThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class ChangeThemeLoading extends ThemeState {
  @override
  List<Object> get props => [];
}

class ChangeThemeLoaded extends ThemeState {
  final String themeMode;
  ChangeThemeLoaded(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}

class ChangeThemeError extends ThemeState {
  @override
  List<Object> get props => [];
}

class GetThemeInitial extends ThemeState {
  @override
  List<Object> get props => [];
}

class GetThemeLoading extends ThemeState {
  @override
  List<Object> get props => [];
}

class GetThemeLoaded extends ThemeState {
  final String themeMode;
  GetThemeLoaded(this.themeMode);
  @override
  List<Object> get props => [themeMode];
}

class GetThemeError extends ThemeState {
  @override
  List<Object> get props => [];
}
