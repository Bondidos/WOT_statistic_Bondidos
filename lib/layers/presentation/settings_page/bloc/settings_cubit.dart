import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/errors/failure.dart';
import '../../../domain/use_cases/sync_theme_use_case.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SyncThemeUseCase sync;

  SettingsCubit({required this.sync}) : super(SettingsInit()) {
    _syncTheme();
  }

  void _syncTheme([String? theme]) async {
    // theme from android platform
    final platformTheme = (theme == null)
        ? await getPlatformTheme()
        : const SettingsError(message: "Storage Error");

    final Either<Failure, String> result = await sync.execute(theme);
    final SettingsState themeState = result.fold((l) {
      return platformTheme;
    }, (r) {
      if (r == DARK_THEME) {
        return const ThemeDark();
      } else {
        return const ThemeLight();
      }
    });
    emit(themeState);
  }

  void switchTheme() {
    if (state is ThemeDark) {
      _syncTheme(LIGHT_THEME);
    } else {
      _syncTheme(DARK_THEME);
    }
  }

  bool get isDarkTheme => (state is ThemeDark) ? true : false;

  // todo theme from web browser (?)
  Future<SettingsState> getPlatformTheme() async {
    const MethodChannel platform = MethodChannel(CHANNEL);
    final String platformTheme;
    try {
      platformTheme = await platform.invokeMethod(GET_THEME);
    } on PlatformException catch (_) {
      return const SettingsError(message: "Error while sync theme");
    }
    if (platformTheme == DARK_THEME) {
      return const ThemeDark();
    } else {
      return const ThemeLight();
    }
  }
}
