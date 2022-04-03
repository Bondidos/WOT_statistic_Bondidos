part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeDark extends ThemeState {
  const ThemeDark();

  @override
  List<Object?> get props => [];
}

class ThemeLight extends ThemeState {
  const ThemeLight();

  @override
  List<Object?> get props => [];
}

class ThemeInit extends ThemeState {

  @override
  List<Object?> get props => [];
}

class ThemeError extends ThemeState {
  final String message;
  const ThemeError({required this.message});

  @override
  List<Object?> get props => [message];
}