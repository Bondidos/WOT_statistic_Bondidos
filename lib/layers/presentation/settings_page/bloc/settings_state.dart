part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();
}

class ThemeDark extends SettingsState {
  const ThemeDark();

  @override
  List<Object?> get props => [];
}

class ThemeLight extends SettingsState {
  const ThemeLight();

  @override
  List<Object?> get props => [];
}

class SettingsInit extends SettingsState {

  @override
  List<Object?> get props => [];
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError({required this.message});

  @override
  List<Object?> get props => [message];
}