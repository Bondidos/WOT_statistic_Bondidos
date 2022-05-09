import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/settings_page/widgets/language_picker.dart';

import 'package:wot_statistic/common/theme/text_styles.dart';
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
    SettingsCubit settingsCubit = context.read<SettingsCubit>();
    SettingsState state = settingsCubit.state;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Settings,
          style: appBarTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _createTitle(S.of(context).ThemeSettings),
            _themeSettings(context, _switchState, settingsCubit, state),
            _createTitle(S.of(context).LocalizationSettings),
            _langSettings(context),
          ],
        ),
      ),
    );
  }

  Widget _createTitle(String title) {
    return Column(
      children: [
        const SizedBox(height: 25),
        Center(
          child: Text(
            title,
            style: onPrimarySubtitle(context),
          ),
        ),
        Divider(thickness: 3, color: Theme.of(context).colorScheme.secondary),
      ],
    );
  }

  Row _langSettings(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                S.of(context).Language,
                style: onSecondarySubtitle(context),
              ),
            ),
          ),
          const Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: LanguagePicker(),
            ),
          ),
        ]);
  }

  Row _themeSettings(BuildContext context, bool _switchState,
      SettingsCubit themeCubit, SettingsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                S.of(context).EnableDarkTheme,
                style: onSecondarySubtitle(context),
              ),
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
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    state.message,
                    style: onSurfaceSubtitle(context),
                  )));
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
    );
  }
}
