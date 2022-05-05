import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/generated/l10n.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/presentation/common_widget/common_widgets.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/floating_button_search.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/themed_button.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/user_picker.dart';

import 'package:wot_statistic/common/theme/text_styles.dart';
import 'package:wot_statistic/layers/presentation/sign_up_user/sign_up_user_page.dart';
import 'package:wot_statistic/layers/presentation/statistic_page/statistic_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const String id = "WOT Statistic";

  @override
  Widget build(BuildContext context) {
    final SingInCubit cubit = context.read<SingInCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).AppName, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsPage.id);
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: BlocConsumer<SingInCubit, SignInState>(
        listener: (prevState, currentState) {
          if (currentState is SignInStateError) {
            createSnackBar(context, currentState.errorMessage);
          }
        },
        buildWhen: (prevState, currentState) =>
            (currentState is SignInStateLoaded ||
                currentState is SignInStateInit),
        builder: (ctx, state) {
          if (state is SignInStateLoaded) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                const AnimatedBackground(),
                const FloatingButtonSearch(heroTag: id),
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      pickRealm(context),
                      const UserPicker(),
                      IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            ThemedButton(
                              title: S.of(context).SignIn,
                              onTap: () async {
                                if (await cubit.signInAction()) {
                                  Navigator.of(context)
                                      .pushReplacementNamed(StatisticPage.id);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            ThemedButton(
                              title: S.of(context).SignUp,
                              onTap: () async {
                                String realm = state.realm;
                                User? user = await Navigator.of(context)
                                    .pushNamed(SignUpPage.id,
                                        arguments: realm) as User?;
                                if (user == null) return;
                                cubit.saveUserInToDataBase(user);
                              },
                            ),
                            const SizedBox(height: 10),
                            ThemedButton(
                              title: S.of(context).Delete,
                              onTap: () => cubit.removeUser(),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  SizedBox pickRealm(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.25,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 15),
            child: Column(
              children: [
                Text(
                  S.of(context).PickRealm,
                  style: onSurfaceSubtitle(context),
                ),
                const RegionPicker(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
