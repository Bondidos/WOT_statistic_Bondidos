import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/settings_page/bloc/settings_cubit.dart';

import '../../../../common/theme/text_styles.dart';

enum MenuOption { eng, ru }

const ruLng = 'ru';
const euLng = 'en';

class LanguagePicker extends StatefulWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  @override
  Widget build(BuildContext context) {
    SettingsCubit settingsCubit = context.read<SettingsCubit>();
    MenuOption picked = settingsCubit.state.languageStatus == ruLng
        ? MenuOption.ru
        : MenuOption.eng;

    return Row(
      children: [
        (picked == MenuOption.eng)
            ? Text(
                S.of(context).English,
                style: onSecondarySubtitle(context),
              )
            : Text(
                S.of(context).Russian,
                style: onSecondarySubtitle(context),
              ),
        PopupMenuButton(
          icon: const Icon(Icons.arrow_drop_down_sharp),
          itemBuilder: (ctx) {
            return <PopupMenuEntry<MenuOption>>[
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    picked = MenuOption.eng;
                  });
                  settingsCubit.setLng(ruLng);
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
                  settingsCubit.setLng(euLng);
                },
                child: Text(
                  S.of(context).Russian,
                  style: onSecondarySubtitle(context),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
