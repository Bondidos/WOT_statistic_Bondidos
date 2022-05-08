import 'package:flutter/material.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/statistic_page.dart';
import 'injection_container.dart' as di;
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'layers/presentation/sign_up_user/sign_up_user_page.dart';
import 'layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';
import 'layers/presentation/sing_in_page/sign_in_page.dart';

const ruLng = 'ru';
const notPicked = "Not Picked";

void main() async {
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SettingsCubit>(create: (ctx) => di.inj<SettingsCubit>()),
      BlocProvider<SingInCubit>(create: (ctx) => di.inj<SingInCubit>()),
    ],
    child: const MyApp(),
  ));
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
                  fontFamily: "Krona One",
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
                  fontFamily: "Krona One",
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
          locale: state.languageStatus == ruLng
              ? const Locale("ru", "BY")
              : const Locale("en", "US"),
          home: Builder(builder: (context) {
            if (state.languageStatus == notPicked) {
              Locale locale = Localizations.localeOf(context);
              context.read<SettingsCubit>().setLng(locale.languageCode);
            }
            return const SignInPage();
          }),
        );
      },
    );
  }
}
