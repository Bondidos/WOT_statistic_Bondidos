import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import '../../../../common/constants/constants.dart';

class RegionPicker extends StatefulWidget {
  const RegionPicker({Key? key}) : super(key: key);

  @override
  State<RegionPicker> createState() => _RegionPickerState();
}

enum MenuOption { ue, cis, none }

class _RegionPickerState extends State<RegionPicker> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingInCubit, SingInState>(
      // todo optimize this method. trigger only when initializing and realmSynced
      buildWhen: (prevState, currentState) => (currentState != prevState),
      builder: (ctx, state) {
        String currentRealm = context.read<SingInCubit>().currentRealm;
        MenuOption picked;
        switch (currentRealm) {
          case EU:
            picked = MenuOption.ue;
            break;
          case CIS:
            picked = MenuOption.cis;
            break;
          default:
            picked = MenuOption.none;
        }
        if(state.status == SingInStatus.realmSynced){
          return Row(
            children: [
              //todo font bigger
              Text(currentRealm),
              PopupMenuButton(
                icon: const Icon(Icons.language),
                itemBuilder: (ctx) {
                  return <PopupMenuEntry<MenuOption>>[
                    PopupMenuItem(
                      onTap: () {
                        context.read<SingInCubit>().setRealmPreference(EU);
                      },
                      child: Wrap(
                        children: [
                          Image.asset("assets/realm/eu.png",
                              height: 20, width: 20),
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("Europe"),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        context.read<SingInCubit>().setRealmPreference(CIS);
                      },
                      child: Wrap(
                        children: [
                          Image.asset("assets/realm/cis.png",
                              height: 20, width: 20),
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
         return Container();
      },
    );
  }
}
