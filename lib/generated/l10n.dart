// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message(
      'Sign In',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get Delete {
    return Intl.message(
      'Delete',
      name: 'Delete',
      desc: '',
      args: [],
    );
  }

  /// `Pick realm`
  String get PickRealm {
    return Intl.message(
      'Pick realm',
      name: 'PickRealm',
      desc: '',
      args: [],
    );
  }

  /// `WOT Statistic`
  String get AppName {
    return Intl.message(
      'WOT Statistic',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `Europe`
  String get Europe {
    return Intl.message(
      'Europe',
      name: 'Europe',
      desc: '',
      args: [],
    );
  }

  /// `CIS`
  String get CIS {
    return Intl.message(
      'CIS',
      name: 'CIS',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Theme Settings`
  String get ThemeSettings {
    return Intl.message(
      'Theme Settings',
      name: 'ThemeSettings',
      desc: '',
      args: [],
    );
  }

  /// `Enable Dark Theme`
  String get EnableDarkTheme {
    return Intl.message(
      'Enable Dark Theme',
      name: 'EnableDarkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Localization Settings`
  String get LocalizationSettings {
    return Intl.message(
      'Localization Settings',
      name: 'LocalizationSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `About App`
  String get AboutApp {
    return Intl.message(
      'About App',
      name: 'AboutApp',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get Russian {
    return Intl.message(
      'Russian',
      name: 'Russian',
      desc: '',
      args: [],
    );
  }

  /// `OpenId Sign Up`
  String get OpenIdSignUp {
    return Intl.message(
      'OpenId Sign Up',
      name: 'OpenIdSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter player name`
  String get EnterPlayerName {
    return Intl.message(
      'Enter player name',
      name: 'EnterPlayerName',
      desc: '',
      args: [],
    );
  }

  /// `Vehicles`
  String get Vehicles {
    return Intl.message(
      'Vehicles',
      name: 'Vehicles',
      desc: '',
      args: [],
    );
  }

  /// `Achieves`
  String get Achieves {
    return Intl.message(
      'Achieves',
      name: 'Achieves',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get Private {
    return Intl.message(
      'Private',
      name: 'Private',
      desc: '',
      args: [],
    );
  }

  /// `To view personal data, sign in first`
  String get InviteToSignIn {
    return Intl.message(
      'To view personal data, sign in first',
      name: 'InviteToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `User have no clan`
  String get NoClanMessage {
    return Intl.message(
      'User have no clan',
      name: 'NoClanMessage',
      desc: '',
      args: [],
    );
  }

  /// `By Level`
  String get ByLevel {
    return Intl.message(
      'By Level',
      name: 'ByLevel',
      desc: '',
      args: [],
    );
  }

  /// `By Battles`
  String get ByBattles {
    return Intl.message(
      'By Battles',
      name: 'ByBattles',
      desc: '',
      args: [],
    );
  }

  /// `By Mastery`
  String get ByMastery {
    return Intl.message(
      'By Mastery',
      name: 'ByMastery',
      desc: '',
      args: [],
    );
  }

  /// `By Wins`
  String get ByWins {
    return Intl.message(
      'By Wins',
      name: 'ByWins',
      desc: '',
      args: [],
    );
  }

  /// `Gold`
  String get Gold {
    return Intl.message(
      'Gold',
      name: 'Gold',
      desc: '',
      args: [],
    );
  }

  /// `Bonds`
  String get Bonds {
    return Intl.message(
      'Bonds',
      name: 'Bonds',
      desc: '',
      args: [],
    );
  }

  /// `Free Exp`
  String get FreeExp {
    return Intl.message(
      'Free Exp',
      name: 'FreeExp',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get Credits {
    return Intl.message(
      'Credits',
      name: 'Credits',
      desc: '',
      args: [],
    );
  }

  /// `Premium`
  String get Premium {
    return Intl.message(
      'Premium',
      name: 'Premium',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get Yes {
    return Intl.message(
      'Yes',
      name: 'Yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get No {
    return Intl.message(
      'No',
      name: 'No',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get Expired {
    return Intl.message(
      'Expired',
      name: 'Expired',
      desc: '',
      args: [],
    );
  }

  /// `Bounded to phone`
  String get BoundedToPhone {
    return Intl.message(
      'Bounded to phone',
      name: 'BoundedToPhone',
      desc: '',
      args: [],
    );
  }

  /// `Battle lifetime`
  String get BattleLifetime {
    return Intl.message(
      'Battle lifetime',
      name: 'BattleLifetime',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Ban time`
  String get BanTime {
    return Intl.message(
      'Ban time',
      name: 'BanTime',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get None {
    return Intl.message(
      'None',
      name: 'None',
      desc: '',
      args: [],
    );
  }

  /// `Chat ban info`
  String get ChatBanInfo {
    return Intl.message(
      'Chat ban info',
      name: 'ChatBanInfo',
      desc: '',
      args: [],
    );
  }

  /// `Expires at`
  String get ExpiresAt {
    return Intl.message(
      'Expires at',
      name: 'ExpiresAt',
      desc: '',
      args: [],
    );
  }

  /// `Signed User is not exist`
  String get SignedUserIsNotExist {
    return Intl.message(
      'Signed User is not exist',
      name: 'SignedUserIsNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Check internet connection`
  String get CheckInternetConnection {
    return Intl.message(
      'Check internet connection',
      name: 'CheckInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get UserNotFound {
    return Intl.message(
      'User not found',
      name: 'UserNotFound',
      desc: '',
      args: [],
    );
  }

  /// `No user to delete`
  String get NoUserToDelete {
    return Intl.message(
      'No user to delete',
      name: 'NoUserToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Please, sign up`
  String get PleaseSignUp {
    return Intl.message(
      'Please, sign up',
      name: 'PleaseSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Token expired, please sign up`
  String get TokenExpired {
    return Intl.message(
      'Token expired, please sign up',
      name: 'TokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `Wins`
  String get Wins {
    return Intl.message(
      'Wins',
      name: 'Wins',
      desc: '',
      args: [],
    );
  }

  /// `Battles`
  String get Battles {
    return Intl.message(
      'Battles',
      name: 'Battles',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `Ussr`
  String get Ussr {
    return Intl.message(
      'Ussr',
      name: 'Ussr',
      desc: '',
      args: [],
    );
  }

  /// `Usa`
  String get Usa {
    return Intl.message(
      'Usa',
      name: 'Usa',
      desc: '',
      args: [],
    );
  }

  /// `China`
  String get China {
    return Intl.message(
      'China',
      name: 'China',
      desc: '',
      args: [],
    );
  }

  /// `Uk`
  String get Uk {
    return Intl.message(
      'Uk',
      name: 'Uk',
      desc: '',
      args: [],
    );
  }

  /// `Czech`
  String get Czech {
    return Intl.message(
      'Czech',
      name: 'Czech',
      desc: '',
      args: [],
    );
  }

  /// `Sweden`
  String get Sweden {
    return Intl.message(
      'Sweden',
      name: 'Sweden',
      desc: '',
      args: [],
    );
  }

  /// `Poland`
  String get Poland {
    return Intl.message(
      'Poland',
      name: 'Poland',
      desc: '',
      args: [],
    );
  }

  /// `Italy`
  String get Italy {
    return Intl.message(
      'Italy',
      name: 'Italy',
      desc: '',
      args: [],
    );
  }

  /// `France`
  String get France {
    return Intl.message(
      'France',
      name: 'France',
      desc: '',
      args: [],
    );
  }

  /// `Japan`
  String get Japan {
    return Intl.message(
      'Japan',
      name: 'Japan',
      desc: '',
      args: [],
    );
  }

  /// `Germany`
  String get Germany {
    return Intl.message(
      'Germany',
      name: 'Germany',
      desc: '',
      args: [],
    );
  }

  /// `No vehicles to show`
  String get NoVehiclesToShow {
    return Intl.message(
      'No vehicles to show',
      name: 'NoVehiclesToShow',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'BY'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
