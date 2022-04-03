import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'layers/presentation/singin_page/bloc/theme_cubit.dart';
import 'layers/presentation/singin_page/singin_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async {
  await di.init();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (ctx) => di.inj<ThemeCubit>())
        ],
        child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ThemeCubit,ThemeState>(
      buildWhen: (prevState, currentState) => (currentState != prevState),
      builder: (ctx,state) {
        return MaterialApp(
          theme:(state is ThemeDark)
          ? ThemeData.dark()
          : ThemeData.light(),
          routes: {
            SingInPage.id: (ctx) => const SingInPage(),
          },
          initialRoute: SingInPage.id,
        );
      },
    );
  }
}

