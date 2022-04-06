import 'package:flutter/material.dart';

enum MenuOption { ue, cis }
//todo save realm to shared prefs
class RegionPicker extends StatefulWidget {
   const RegionPicker({Key? key}) : super(key: key);

  @override
  State<RegionPicker> createState() => _RegionPickerState();
}

class _RegionPickerState extends State<RegionPicker> {
   MenuOption picked = MenuOption.ue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //todo font bigger
        (picked == MenuOption.ue)
        ? const Text("EU")
        : const Text("CIS"),
        PopupMenuButton(
          icon: const Icon(Icons.language),
          itemBuilder: (ctx) {
            return <PopupMenuEntry<MenuOption>>[
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    picked = MenuOption.ue;
                  });
                  //todo set realm (cubit)
                },
                child: Wrap(
                  children: [
                    Image.asset("assets/realm/eu.png", height: 20, width: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Europe"),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    picked = MenuOption.cis;
                  });
                  //todo set realm (cubit)
                },
                child: Wrap(
                  children: [
                    Image.asset("assets/realm/cis.png", height: 20, width: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("CIS"),
                    ),
                  ],
                ),
              ),
            ];
          },
        ),
      ],
    );
  }
}
