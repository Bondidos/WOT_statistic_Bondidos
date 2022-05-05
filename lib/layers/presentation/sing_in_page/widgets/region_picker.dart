import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';

import 'package:wot_statistic/common/constants/constants.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';

class RegionPicker extends StatelessWidget {
  const RegionPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SingInCubit cubit = context.read<SingInCubit>();

    return BlocBuilder<SingInCubit, SignInState>(
      buildWhen: (prevState, currentState) =>
          (currentState is SignInStateLoaded),
      builder: (ctx, state) {
        return Row(
          children: [
            Text(
              cubit.currentRealm,
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
                      if (cubit.currentRealm != EU) {
                        cubit.setNewRealm(EU);
                      }
                    },
                    child: Wrap(
                      children: [
                        Image.asset("assets/realm/eu.png",
                            height: 20, width: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            S.of(context).Europe,
                            style: onSurfaceSubtitle(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      if (cubit.currentRealm != CIS) {
                        cubit.setNewRealm(CIS);
                      }
                    },
                    child: Wrap(
                      children: [
                        Image.asset("assets/realm/cis.png",
                            height: 20, width: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            S.of(context).CIS,
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
      },
    );
  }
}
