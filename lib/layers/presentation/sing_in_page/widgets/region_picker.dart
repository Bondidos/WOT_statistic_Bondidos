import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import '../../../../common/constants/constants.dart';

class RegionPicker extends StatelessWidget {
  const RegionPicker({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingInCubit, SingInState>(
      buildWhen: (prevState, currentState) =>
          (currentState.status == SingInStatus.realmSynced &&
              currentState != prevState),
      builder: (ctx, state) {

        if (state.status == SingInStatus.realmSynced) {

          String currentRealm = context.read<SingInCubit>().currentRealm;

          return Row(
            children: [
              //todo font bigger
              Text(currentRealm),
              PopupMenuButton(
                icon: const Icon(Icons.language),
                itemBuilder: (ctx) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {
                        if (currentRealm != EU) {
                          context.read<SingInCubit>().setRealmPreference(EU);
                        }
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
                        if (currentRealm != CIS) {
                          context.read<SingInCubit>().setRealmPreference(CIS);
                        }
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
        } else {
          return const Text(NOT_PICKED);
        }
      },
    );
  }
}
