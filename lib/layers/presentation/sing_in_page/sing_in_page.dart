import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/themed_button.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/user_picker.dart';
import 'package:wot_statistic/layers/presentation/singup_user/singup_user_page.dart';

import '../../../common/theme/text_styles.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key}) : super(key: key);

  static const String id = "WOT Statistic";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SingInPage.id, style: appBarTitle(context)),
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
      body: BlocConsumer<SingInCubit, SingInState>(
        listener: (prevState, currentState) {
          if (currentState.status == SingInStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  currentState.errorMessage!,
                  style: onSecondarySubtitle(context),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        buildWhen: (prevState, currentState) =>
            (currentState.status == SingInStatus.initialized ||
                currentState.status == SingInStatus.initializing ||
                currentState.status == SingInStatus.usersSynced),
        builder: (ctx, state) {
          if (state.status == SingInStatus.initialized ||
              state.status == SingInStatus.usersSynced) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                const AnimatedBackground(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Wrap(
                              children: [
                                Text(
                                  "Pick realm",
                                  style: onSurfaceSubtitle(context),
                                ),
                                const RegionPicker()
                              ],
                            ),
                          ),
                        ),
                      ),
                      const UserPicker(),
                      const SizedBox(height: 20),
                      ThemedButton(
                        title: "Sing In",
                        onTap: () {
                          if (state.prevUsers.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please, sing up first",
                                  style: onSecondarySubtitle(context),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                          //todo validate user token
                          //todo navigate statisticScreen
                        },
                      ),
                      const SizedBox(height: 20),
                      ThemedButton(
                          title: "Sing Up",
                          onTap: () async {
                            String realm =
                                context.read<SingInCubit>().currentRealm;

                            User? user = await Navigator.of(context)
                                    .pushNamed(SingUpPage.id, arguments: realm)
                                as User?;

                            if (user != null) {
                              context
                                  .read<SingInCubit>()
                                  .saveUserInToDataBase(user);
                            }
                          }),
                      const SizedBox(height: 20),
                      ThemedButton(
                          title: "Delete",
                          onTap: () {
                            context.read<SingInCubit>().removeUser();
                          }),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
