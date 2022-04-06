import 'package:flutter/material.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'injection_container.dart' as di;
import 'layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layers/presentation/sing_in_page/sing_in_page.dart';

void main() async {
  await di.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SettingsCubit>(create: (ctx) => di.inj<SettingsCubit>()),
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
              ? ThemeData.dark()
              : ThemeData.light(),
          routes: {
            SingInPage.id: (ctx) => const SingInPage(),
            SettingsPage.id: (ctx) => const SettingsPage(),
          },
          initialRoute: SingInPage.id,
        );
      },
    );
  }
}
