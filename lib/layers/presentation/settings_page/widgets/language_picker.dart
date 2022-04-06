import 'package:flutter/material.dart';

enum MenuOption { eng, ru }
//todo lang realm to shared prefs
class LanguagePicker extends StatefulWidget {
  const LanguagePicker({Key? key}) : super(key: key);

  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {

  // todo sync with native? / set from prefs
  MenuOption picked = MenuOption.eng;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        //todo font bigger
        (picked == MenuOption.eng)
            ? const Text("English")
            : const Text("Russian"),
        PopupMenuButton(
          icon: const Icon(Icons.arrow_drop_down_sharp),
          itemBuilder: (ctx) {
            return <PopupMenuEntry<MenuOption>>[
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    picked = MenuOption.eng;
                  });
                  //todo set lang (ThemeCubit)
                },
                child: const Text("English"),
                ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    picked = MenuOption.ru;
                  });
                  //todo set lang (cubit)
                },
                child: const Text("Russian"),
                ),
            ];
          },
        ),
      ],
    );
  }

}