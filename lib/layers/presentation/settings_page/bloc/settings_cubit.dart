import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_language_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_theme_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_language_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_theme_use_case.dart';
import 'package:wot_statistic/common/constants.dart';

part 'settings_state.dart';

const init = 'init';
const getTheme = "getTheme";
const channel = "com.bondidos.wot_statistic/theme";
const lightTheme = "Light";
const darkTheme = "Dark";

class SettingsCubit extends Cubit<SettingsState> {
  final SubscribeThemeUseCase subscribeTheme;
  final SetThemeUseCase setTheme;
  final SubscribeLanguageUseCase subscribeLanguage;
  final SetLanguageUseCase setLanguageUseCase;
  StreamSubscription? _subscriptionTheme;
  StreamSubscription? _subscriptionLanguage;

  SettingsCubit({
    required this.subscribeTheme,
    required this.setTheme,
    required this.setLanguageUseCase,
    required this.subscribeLanguage,
  }) : super(const SettingsState(
          languageStatus: init,
          themeStatus: init,
          status: SettingsStatus.init,
        )) {
    _init();
  }

  bool get isDarkTheme => (state.themeStatus == darkTheme) ? true : false;

  void _init() {
    _subscriptionTheme = subscribeTheme.execute().listen((theme) {
      if (theme == notPicked) {
        _setDefaultTheme();
        return;
      }
      emit(state.copyWith(
          themeStatus: theme, status: SettingsStatus.themeStatusChanged));
    });
    _subscriptionLanguage = subscribeLanguage.execute().listen((language) {
      emit(state.copyWith(
          languageStatus: language, status: SettingsStatus.languageStatusChanged));
    });
  }

  void _setDefaultTheme() async {
    String platformTheme = await getPlatformOrLiteTheme();
    setTheme.execute(platformTheme);
  }

  void setLanguage(String locale) {
    if (locale == ruLanguage) {
      setLanguageUseCase.execute(ruLanguage);
    } else {
      setLanguageUseCase.execute(engLanguage);
    }
  }

  void switchTheme() {
    if (state.themeStatus == darkTheme) {
      setTheme.execute(lightTheme);
    } else {
      setTheme.execute(darkTheme);
    }
  }

  Future<String> getPlatformOrLiteTheme() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      const MethodChannel platform = MethodChannel(channel);
      final String platformTheme;
      try {
        platformTheme = await platform.invokeMethod(getTheme);
        return platformTheme;
      } on PlatformException catch (_) {
        return lightTheme;
      }
    }
    return lightTheme;
  }

  @override
  Future<void> close() {
    _subscriptionTheme?.cancel();
    _subscriptionLanguage?.cancel();
    return super.close();
  }
}
