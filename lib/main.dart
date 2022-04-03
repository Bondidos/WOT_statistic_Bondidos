import 'package:flutter/material.dart';
import 'layers/presentation/singin_page/singin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //todo create dark and light themes
      theme: ThemeData.light(),
      routes: {
        SingInPage.id: (ctx) => const SingInPage(),
      },
      initialRoute: SingInPage.id,
    );
  }
}

