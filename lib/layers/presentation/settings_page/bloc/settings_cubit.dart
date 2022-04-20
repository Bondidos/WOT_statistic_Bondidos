import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_theme_use_case.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/constants/shared_pref_keys.dart';
import '../../../domain/use_cases/subscribe_theme_use_case.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SubscribeThemeUseCase subscribeTheme;
  final SetThemeUseCase setTheme;
  StreamSubscription? _subscriptionTheme;

  SettingsCubit({required this.subscribeTheme, required this.setTheme})
      : super(SettingsInit()) {
    _init();
  }

  bool get isDarkTheme => (state is ThemeDark) ? true : false;

  void _init() {
    _subscriptionTheme = subscribeTheme.execute().listen((theme) {
      if (theme == NOT_PICKED) {
        _setDefaultTheme();
        return;
      }
      emit((theme == LIGHT_THEME) ? const ThemeLight() : const ThemeDark());
    });
  }

  void _setDefaultTheme() async{
    String platformTheme = await getPlatformTheme();
    setTheme.execute(platformTheme);
  }

  void switchTheme() {
    if (state is ThemeDark) {
      setTheme.execute(LIGHT_THEME);
    } else {
      setTheme.execute(DARK_THEME);
    }
  }

  // LIGHT THEME AS DEFAULT
  Future<String> getPlatformTheme() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      const MethodChannel platform = MethodChannel(CHANNEL);
      final String platformTheme;
      try {
        platformTheme = await platform.invokeMethod(GET_THEME);
        return platformTheme;
      } on PlatformException catch (_) {
        return LIGHT_THEME;
      }
    }
    return LIGHT_THEME;
  }

  @override
  Future<void> close() {
    _subscriptionTheme?.cancel();
    return super.close();
  }
}
