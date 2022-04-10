import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/settings_page/widgets/language_picker.dart';

import '../../../common/theme/text_styles.dart';
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
        title: Text(
          SettingsPage.id,
          style: appBarTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Center(
                child: Text(
              "Theme Settings",
              style: onPrimarySubtitle(context),
            )),
            Divider(
              thickness: 3,
              color: Theme.of(context).colorScheme.secondary
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Enable Dark Theme",
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
            ),
            const SizedBox(height: 25),
            Center(
                child: Text(
              "Localization Settings",
              style: onPrimarySubtitle(context),
            )),
            Divider(
              thickness: 3,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Language",
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
                ]),
            const SizedBox(height: 25),
            Center(
                child: Text(
              "About App",
              style: onPrimarySubtitle(context),
            )),
            Divider(
              thickness: 3,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
