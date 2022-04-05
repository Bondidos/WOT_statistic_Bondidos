import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/singin_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/singin_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/singin_page/widgets/themed_button.dart';
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
              onPressed: (){},
              icon: const Icon(Icons.settings)
          )
        ],
      ),
      body: Stack(
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
                    },
                ),
                const SizedBox(height: 20),
                 ThemedButton(
                  title: "Sing Up",
                  onTap: () {
                    //todo navigate webView SingUp
                  }
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


