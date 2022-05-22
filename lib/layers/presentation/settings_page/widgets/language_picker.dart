import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/settings_page/bloc/settings_cubit.dart';
import 'package:wot_statistic/common/text_styles.dart';

enum MenuOption { eng, ru }

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = context.read<SettingsCubit>();
    MenuOption picked = settingsCubit.state.languageStatus == ruLanguage
        ? MenuOption.ru
        : MenuOption.eng;

    return PopupMenuButton(
      child: TextButton.icon(
        onPressed: null,
        label: (picked == MenuOption.eng)
            ? Text(
                S.of(context).English,
                style: onSecondarySubtitle(context),
              )
            : Text(
                S.of(context).Russian,
                style: onSecondarySubtitle(context),
              ),
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      itemBuilder: (ctx) {
        return <PopupMenuEntry<MenuOption>>[
          PopupMenuItem(
            onTap: () {
              setState(() {
                picked = MenuOption.eng;
              });
              settingsCubit.setLanguage(engLanguage);
            },
            child: Text(
              S.of(context).English,
              style: onSecondarySubtitle(context),
            ),
          ),
          PopupMenuItem(
            onTap: () {
              setState(() {
                picked = MenuOption.ru;
              });
              settingsCubit.setLanguage(ruLanguage);
            },
            child: Text(
              S.of(context).Russian,
              style: onSecondarySubtitle(context),
            ),
          ),
        ];
      },
    );
  }
}
