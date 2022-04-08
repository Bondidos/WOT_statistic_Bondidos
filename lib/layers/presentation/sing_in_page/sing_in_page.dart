import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/domain/entities/user.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/themed_button.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/user_picker.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key}) : super(key: key);

  static const String id = "WOT Statistic";

/*
  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  //todo move here sizes (mediaquery)
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SingInPage.id),
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
              icon: const Icon(Icons.settings))
        ],
      ),


      //todo loading indicator: place as top of the stack


      body: BlocBuilder<SingInCubit, SingInState>(
        buildWhen: (prevState, currentState) =>
            (currentState.status == SingInStatus.initialized &&
                currentState != prevState),
        builder: (ctx, state) {
          if (state.status == SingInStatus.initialized) {
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
                              children: const [Text("Region"), RegionPicker()],
                            ),
                          ),
                        ),
                      ),
                      const UserPicker(),
                      const SizedBox(height: 20),
                      ThemedButton(
                        title: "Sing In",
                        onTap: () {
                          //todo navigate statisticScreen
                          // context.read<SingInCubit>().listUsers();
                        },
                      ),
                      const SizedBox(height: 20),
                      ThemedButton(
                          title: "Sing Up",
                          onTap: () {
                            /**
                             * Testing save user in to DB
                             * */
                            Random rd = Random();
                            var rand = rd.nextInt(10000);
                            context.read<SingInCubit>().saveUserInToDataBase(
                                User(
                                  id:rand,
                                  nickname: "nickname$rand",
                                  accessToken: "accessToken",
                                  expiresAt: rand+1,
                                )
                            );

                            //todo navigate webView SingUp, await result, save into repo

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
