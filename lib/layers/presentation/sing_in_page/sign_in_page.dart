import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sign_in_cubit.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/themed_button.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/user_picker.dart';

import '../../../common/theme/text_styles.dart';
import '../sign_up_user/sign_up_user_page.dart';
import '../statistic_page/statistic_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  static const String id = "WOT Statistic";

  @override
  Widget build(BuildContext context) {
    final SingInCubit cubit = context.read<SingInCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(id, style: appBarTitle(context)),
        actions: [
          IconButton(
            onPressed: () {
              //todo search player in directed realm (cubit)
            },
            icon: const Icon(Icons.search),
          ),
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  currentState.errorMessage,
                  style: onSecondarySubtitle(context),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
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
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 15),
                            child: Wrap(
                              children: [
                                Text(
                                  "Pick realm",
                                  style: onSurfaceSubtitle(context),
                                ),
                                const RegionPicker(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const UserPicker(),
                      IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 20),
                            ThemedButton(
                              title: "Sign In",
                              onTap: () async {
                                if (await cubit.signInAction()) {
                                  Navigator.of(context)
                                      .pushReplacementNamed(StatisticPage.id);
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            ThemedButton(
                                title: "Sign Up",
                                onTap: () async {
                                  String realm = state.realm;

                                  User? user = await Navigator.of(context)
                                      .pushNamed(SignUpPage.id,
                                          arguments: realm) as User?;
                                  if (user == null) return;
                                  cubit.saveUserInToDataBase(user);
                                }),
                            const SizedBox(height: 10),
                            ThemedButton(
                              title: "Delete",
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
}
