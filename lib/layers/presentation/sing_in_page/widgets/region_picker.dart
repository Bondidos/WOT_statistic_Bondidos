import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';

const cis = "CIS";
const euRealm = "assets/realm/eu.png";
const cisRealm = "assets/realm/cis.png";

class RegionPicker extends StatelessWidget {
  const RegionPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignInCubit cubit = context.read<SignInCubit>();

    return BlocBuilder<SignInCubit, SignInState>(
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
                      if (cubit.currentRealm != defaultRealm) {
                        cubit.setNewRealm(defaultRealm);
                      }
                    },
                    child: Wrap(
                      children: [
                        Image.asset(
                          euRealm,
                          height: 20,
                          width: 20,
                        ),
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
                      if (cubit.currentRealm != cis) {
                        cubit.setNewRealm(cis);
                      }
                    },
                    child: Wrap(
                      children: [
                        Image.asset(
                          cisRealm,
                          height: 20,
                          width: 20,
                        ),
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
