import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';

import '../../../../common/constants/constants.dart';
import '../../../../common/theme/text_styles.dart';

class RegionPicker extends StatelessWidget {
  const RegionPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingInCubit, SingInState>(
      buildWhen: (prevState, currentState) =>
          (currentState.status == SingInStatus.realmSynced),
      builder: (ctx, state) {
        // if (state.status == SingInStatus.realmSynced) {
          final String currentRealm = state.realm;

          return Row(
            children: [
              Text(
                currentRealm,
                style: onSurfaceSubtitle(context),
              ),
              PopupMenuButton(
                color: Theme.of(context).colorScheme.secondary,
                icon: Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                itemBuilder: (ctx) {
                  return <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () {
                        if (currentRealm != EU) {
                         context.read<SingInCubit>().setNewRealm(EU);
                        }
                      },
                      child: Wrap(
                        children: [
                          Image.asset("assets/realm/eu.png",
                              height: 20, width: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Europe",
                              style: onSurfaceSubtitle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        if (currentRealm != CIS) {
                         context.read<SingInCubit>().setNewRealm(CIS);
                        }
                      },
                      child: Wrap(
                        children: [
                          Image.asset("assets/realm/cis.png",
                              height: 20, width: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "CIS",
                              style: onSurfaceSubtitle(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            ],
          );
        // }
        // return const Text(NOT_PICKED);
      },
    );
  }
}
