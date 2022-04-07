import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wot_statistic/layers/presentation/settings_page/settings_page.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/bloc/sing_in_cubit.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/animated_background.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/region_picker.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/themed_button.dart';
import 'package:wot_statistic/layers/presentation/sing_in_page/widgets/user_picker.dart';



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
              onPressed: (){
                Navigator.of(context).pushNamed(SettingsPage.id);
              },
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
                BlocBuilder<SingInCubit,SingInState>(
                    builder: (BuildContext context, state) {
                      return const UserPicker();
                    },
                ),
                const SizedBox(height: 20),
                ThemedButton(
                    title: "Sing In",
                    onTap: () {
                      //todo navigate statisticScreen
                      context.read<SingInCubit>().listUsers();
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


