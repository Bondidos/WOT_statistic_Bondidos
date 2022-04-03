import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/singin_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/singin_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/singin_page/widgets/user_picker.dart';

import 'bloc/theme_cubit.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({Key? key}) : super(key: key);

  static const String id = "WOT Statistic";

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  //todo move here sizes (mediaquery)

  @override
  Widget build(BuildContext context) {

    bool _switchState = context.read<ThemeCubit>().isDarkTheme;
    ThemeCubit themeCubit = context.read<ThemeCubit>();
    ThemeState state = themeCubit.state;

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
          const RegionPicker(),
          Switch(
            value: _switchState,
            onChanged: (value) {
              themeCubit.switchTheme();
              if(state is ThemeError){
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)));
              } else {
                setState(() {
                  _switchState = !value;
                });
              }
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const AnimatedBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 2),
                const UserPicker(),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                      onPressed: () {
                        //todo navigate statisticScreen
                      },
                      child: const Text('Sign In')),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                      onPressed: () {
                        //todo navigate to SingUpScreen
                      },
                      child: const Text('Sign Up')),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
