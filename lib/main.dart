import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/statistic_page.dart';
import 'common/constants.dart';
import 'injection_container.dart' as di;
import 'layers/data/sources/settings/realm_settings.dart';
import 'layers/data/sources/settings/user_settings.dart';
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'layers/presentation/sign_up_user/sign_up_user_page.dart';
import 'layers/presentation/sing_in_page/sign_in_page.dart';

void main() async {
  await di.init();
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    BlocProvider<SettingsCubit>(
      create: (ctx) => di.inj<SettingsCubit>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (prevState, currentState) => (prevState != currentState),
      builder: (context, state) {
        return MaterialApp(
          theme: (state.themeStatus == darkTheme)
              ? ThemeData(
                  primaryColor: const Color(0xffdbcbcb),
                  colorScheme: const ColorScheme.dark().copyWith(
                    primary: const Color(0xff14213d),
                    secondary: const Color(0xff003566),
                    onPrimary: const Color(0xfffca311),
                    onSurface: const Color(0xff98c1d9),
                    onSecondary: const Color(0xfffca311),
                  ),
                  fontFamily: "SourceSansPro",
                )
              : ThemeData(
                  primaryColor: const Color(0xffdbcbcb),
                  colorScheme: const ColorScheme.light().copyWith(
                    primary: const Color(0xfff4845f),
                    secondary: const Color(0xff8d99ae),
                    onPrimary: const Color(0xff2b2d42),
                    onSurface: const Color(0xfff3dca2),
                    onSecondary: const Color(0xff5ba8cb),
                  ),
                  fontFamily: "SourceSansPro",
                ),
          routes: {
            SignInPage.id: (ctx) => const SignInPage(),
            SettingsPage.id: (ctx) => const SettingsPage(),
            SignUpPage.id: (ctx) => const SignUpPage(),
            StatisticPage.id: (ctx) => const StatisticPage(),
          },
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: state.languageStatus == ruLanguage
              ? const Locale("ru", "BY")
              : const Locale("en", "US"),
          home: Builder(
            builder: (context) {
              if (state.languageStatus == notPicked) {
                Locale locale = Localizations.localeOf(context);
                context.read<SettingsCubit>().setLanguage(locale.languageCode);
              }
              if (_isSignedUserAbleToSkipSignInScreen()) {
                return const StatisticPage();
              }
              return const SignInPage();
            },
          ),
        );
      },
    );
  }

  bool _isSignedUserAbleToSkipSignInScreen() {
    final UserSettings userSettings = di.inj<UserSettings>();
    final RealmSettings realmSettings = di.inj<RealmSettings>();
    final int tokenExpInSeconds;
    final String currentRealm;
    final String signedUserRealm;
    try {
      tokenExpInSeconds = userSettings.signedUser.expiresAt * 1000;
      currentRealm = realmSettings.currentRealm;
      signedUserRealm = userSettings.signedUser.realm;
    } catch (e) {
      return false;
    }
    return (tokenExpInSeconds > DateTime.now().millisecondsSinceEpoch &&
        currentRealm == signedUserRealm);
  }
}
