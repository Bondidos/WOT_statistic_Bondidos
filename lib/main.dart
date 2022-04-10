import 'package:flutter/material.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/singup_user/singup_user_page.dart';
import 'injection_container.dart' as di;
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';
import 'layers/presentation/sing_in_page/sing_in_page.dart';

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
      buildWhen: (prevState, currentState) => (currentState != prevState),
      builder: (ctx, state) {
        if (state is SettingsInit) {
          return const CircularProgressIndicator();
        }
        return MaterialApp(
          theme: (state is ThemeDark)
              ? ThemeData(
                  colorScheme: const ColorScheme.dark().copyWith(
                    primary: const Color(0xff14213d),
                    secondary: const Color(0xff003566),
                    onPrimary: const Color(0xfffca311),
                    onSurface: const Color(0xff98c1d9),
                  ),
                  fontFamily: "Krona One",
                )
              : ThemeData(
                  primaryColor: const Color(0xfff3dca2),
                  colorScheme: const ColorScheme.light().copyWith(
                    primary: const Color(0xfff4845f),
                    secondary: const Color(0xff8d99ae),
                    onPrimary: const Color(0xff2b2d42),
                    onSurface: const Color(0xfff3dca2), //0xff1f1f2d
                  ),
                  fontFamily: "Krona One",
                ),
          routes: {
            SingInPage.id: (ctx) => const SingInPage(),
            SettingsPage.id: (ctx) => const SettingsPage(),
            SingUpPage.id: (ctx) => const SingUpPage(),
          },
          initialRoute: SingInPage.id,
        );
      },
    );
  }
}
