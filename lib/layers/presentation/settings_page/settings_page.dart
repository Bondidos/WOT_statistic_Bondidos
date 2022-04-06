import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/settings_page/widgets/language_picker.dart';

import 'bloc/settings_cubit.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String id = 'Settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool _switchState = context.read<SettingsCubit>().isDarkTheme;
    SettingsCubit themeCubit = context.read<SettingsCubit>();
    SettingsState state = themeCubit.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingsPage.id),
      ),
      body: Column(
        children: [
          const SizedBox(height: 25),
          const Center(child: Text("Theme Settings")),
          Divider(
            thickness: 3,
            color: Theme.of(context).dividerColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Enable Dark Theme"),
                  )),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Switch(
                    value: _switchState,
                    onChanged: (value) {
                      themeCubit.switchTheme();
                      if (state is SettingsError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      } else {
                        setState(() {
                          _switchState = !value;
                        });
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Center(child: Text("Localization Settings")),
          Divider(
            thickness: 3,
            color: Theme.of(context).dividerColor,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Flexible(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Language"),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: LanguagePicker(),
                  ),
                ),
              ]),
          const SizedBox(height: 25),
          const Center(child: Text("About App")),
          Divider(
            thickness: 3,
            color: Theme.of(context).dividerColor,
          ),
        ],
      ),
    );
  }
}



