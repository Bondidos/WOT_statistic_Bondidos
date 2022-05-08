import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_lng_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/set_theme_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_lng_use_case.dart';
import 'package:wot_statistic/layers/domain/use_cases/subscribe_theme_use_case.dart';

part 'settings_state.dart';

const ruLng = 'ru';
const engLng = 'en';
const init = 'init';
const notPicked = "Not Picked";
const getTheme = 'getTheme';
const channel = "com.bondidos.wot_statistic/theme";
const lightTheme = "Light";
const darkTheme = "Dark";

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
    _subscriptionLng = subscribeLng.execute().listen((lng) {
      emit(state.copyWith(
          languageStatus: lng, status: SettingsStatus.languageStatusChanged));
    });
  }

  void _setDefaultTheme() async {
    String platformTheme = await getPlatformOrLiteTheme();
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
    _subscriptionLng?.cancel();
    return super.close();
  }
}
