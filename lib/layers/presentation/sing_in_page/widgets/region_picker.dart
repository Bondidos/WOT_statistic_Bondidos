import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/common/constants.dart';
import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';

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
            PopupMenuButton(
              color: Theme.of(context).colorScheme.secondary,
              child: TextButton.icon(
                onPressed: null,
                label: Text(
                  cubit.currentRealm,
                  style: onSurfaceSubtitle(context),
                ),
                icon: Icon(
                  Icons.language,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              itemBuilder: (ctx) {
                return <PopupMenuEntry>[
                  buildPopupMenuItem(
                      cubit: cubit,
                      context: context,
                      imageAsset: euRealm,
                      text: S.of(context).Europe,
                      onTap: () {
                        if (cubit.currentRealm != eu) {
                          cubit.setNewRealm(eu);
                        }
                      }),
                  buildPopupMenuItem(
                    cubit: cubit,
                    context: context,
                    imageAsset: cisRealm,
                    text: S.of(context).CIS,
                    onTap: () {
                      if (cubit.currentRealm != cis) {
                        cubit.setNewRealm(cis);
                      }
                    },
                  ),
                ];
              },
            ),
          ],
        );
      },
    );
  }

  PopupMenuItem<dynamic> buildPopupMenuItem({
    required SignInCubit cubit,
    required BuildContext context,
    required String imageAsset,
    required Function onTap,
    required String text,
  }) {
    return PopupMenuItem(
      onTap: () => onTap(),
      child: Wrap(
        children: [
          Image.asset(
            imageAsset,
            height: 20,
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: onSurfaceSubtitle(context),
            ),
          ),
        ],
      ),
    );
  }
}
