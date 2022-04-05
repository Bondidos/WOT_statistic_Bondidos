
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../singin_page/bloc/theme_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {


    bool _switchState = context.read<ThemeCubit>().isDarkTheme;
    ThemeCubit themeCubit = context.read<ThemeCubit>();
    ThemeState state = themeCubit.state;


    return Column(
      children: [
        Row(
          children: [
            Text("Enable Dark Theme"),
            Switch(
              value: _switchState,
              onChanged: (value) {
                themeCubit.switchTheme();
                if (state is ThemeError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                } else {
                  setState(() {
                    _switchState = !value;
                  });
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
