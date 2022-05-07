import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_lng_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_theme_use_case.dart';

import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/common/constants/shared_pref_keys.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_lng_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_theme_use_case.dart';

part 'settings_state.dart';

const ruLng = 'ru';
const engLng = 'eng';
const init = 'init';

class SettingsCubit extends Cubit<SettingsState> {
  final SubscribeThemeUseCase subscribeTheme;
  final SetThemeUseCase setTheme;
  final SubscribeLng subscribeLng;
  final SetLngUseCase setLngUseCase;
  StreamSubscription? _subscriptionTheme;
  StreamSubscription? _subscriptionLng;

  SettingsCubit({
    required this.subscribeTheme,
    required this.setTheme,
    required this.setLngUseCase,
    required this.subscribeLng,
  }) : super(const SettingsState(
          languageStatus: init,
          themeStatus: init,
          status: SettingsStatus.init,
        )) {
    _init();
  }

  bool get isDarkTheme => (state.themeStatus == DARK_THEME) ? true : false;

  void _init() {
    _subscriptionTheme = subscribeTheme.execute().listen((theme) {
      if (theme == NOT_PICKED) {
        _setDefaultTheme();
        return;
      }
      emit(state.copyWith(
          themeStatus: theme, status: SettingsStatus.themeStatusChanged));
    });
    _subscriptionLng = subscribeLng.execute().listen((lng) {
      emit(state.copyWith(
          languageStatus: lng, status: SettingsStatus.languageStatusChanged));
    });
  }

  void _setDefaultTheme() async {
    String platformTheme = await getPlatformTheme();
    setTheme.execute(platformTheme);
  }

  void setLng(String locale) {
    if (locale == ruLng) {
      setLngUseCase.execute(ruLng);
    } else {
      setLngUseCase.execute(engLng);
    }
  }

  void switchTheme() {
    if (state.themeStatus == DARK_THEME) {
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
    _subscriptionLng?.cancel();
    return super.close();
  }
}
