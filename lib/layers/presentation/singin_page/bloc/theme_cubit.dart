import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:wot_statistic/layers/domain/usecases/sync_theme_usecase.dart';

import '../../../../common/constants/constants.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SyncThemeUseCase sync;

  ThemeCubit({required this.sync}) : super(ThemeInit()) {
    _syncTheme();
  }

  void _syncTheme([String? theme]) async {
    // theme from android platform
    final platformTheme = (theme == null)
        ? await getPlatformTheme()
        : const ThemeError(message: "Storage Error");

    final result = await sync.execute(theme);
    final themeState = result.fold((l) {
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

  Future<ThemeState> getPlatformTheme() async {
    var platform = const MethodChannel(CHANNEL);
    final String platformTheme;
    try {
      platformTheme = await platform.invokeMethod(GET_THEME);
    } on PlatformException catch (e) {
      return const ThemeError(message: "Error while sync theme");
    }
    if (platformTheme == DARK_THEME) {
      return const ThemeDark();
    } else {
      return const ThemeLight();
    }
  }
}
