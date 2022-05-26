part of 'settings_cubit.dart';

enum SettingsStatus { init, themeStatusChanged, languageStatusChanged, error }

class SettingsState extends Equatable {
  final String themeStatus;
  final String languageStatus;
  final SettingsStatus status;

  const SettingsState({
    required this.languageStatus,
    required this.themeStatus,
    required this.status,
  });

  @override
  List<Object?> get props => [languageStatus, themeStatus, status];

  SettingsState copyWith(
      {String? themeStatus, String? languageStatus, SettingsStatus? status}) {
    return SettingsState(
        themeStatus: themeStatus ?? this.themeStatus,
        status: status ?? this.status,
        languageStatus: languageStatus ?? this.languageStatus);
  }
}

class SettingsError extends SettingsState {
  final String message;

  const SettingsError({required this.message})
      : super(
            languageStatus: '', themeStatus: '', status: SettingsStatus.error);

  @override
  List<Object?> get props => [message];
}
